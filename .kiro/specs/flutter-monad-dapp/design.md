# Design Document

## Overview

Bu Flutter web dApp, Monad blockchain ile etkileşim kurmak için MVVM mimarisi ve Riverpod state management kullanacaktır. Uygulama, kullanıcıların cüzdan bağlayabilmesi, bakiye görüntüleyebilmesi, token transfer yapabilmesi ve işlem geçmişini takip edebilmesi için gerekli tüm bileşenleri içerecektir.

## Architecture

### MVVM Pattern Implementation

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│      View       │    │   ViewModel     │    │     Model       │
│   (Widgets)     │◄──►│  (Providers)    │◄──►│  (Services)     │
│                 │    │                 │    │                 │
│ - HomePage      │    │ - WalletVM      │    │ - WalletService │
│ - WalletWidget  │    │ - TransferVM    │    │ - Web3Service   │
│ - TransferForm  │    │ - HistoryVM     │    │ - ApiService    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

### Technology Stack

- **Frontend**: Flutter Web
- **State Management**: Riverpod
- **Blockchain Integration**: web3dart
- **HTTP Client**: dio
- **Routing**: go_router
- **UI Components**: Material Design 3

## Components and Interfaces

### 1. Core Services (Model Layer)

#### Web3Service
```dart
class Web3Service {
  Future<Web3Client> getClient();
  Future<EthereumAddress> getCurrentAddress();
  Future<EtherAmount> getBalance(EthereumAddress address);
  Future<String> sendTransaction(Transaction transaction);
  Future<List<TransactionInformation>> getTransactionHistory(EthereumAddress address);
}
```

#### WalletService
```dart
class WalletService {
  Future<bool> connectWallet();
  Future<void> disconnectWallet();
  Future<EthereumAddress?> getConnectedAddress();
  Stream<WalletConnectionState> get connectionStream;
}
```

### 2. ViewModels (Riverpod Providers)

#### WalletViewModel
```dart
@riverpod
class WalletViewModel extends _$WalletViewModel {
  @override
  WalletState build() => const WalletState.initial();
  
  Future<void> connectWallet();
  Future<void> disconnectWallet();
  Future<void> refreshBalance();
}
```

#### TransferViewModel
```dart
@riverpod
class TransferViewModel extends _$TransferViewModel {
  @override
  TransferState build() => const TransferState.initial();
  
  Future<void> sendTokens(String toAddress, double amount);
  void updateRecipient(String address);
  void updateAmount(double amount);
}
```

#### TransactionHistoryViewModel
```dart
@riverpod
class TransactionHistoryViewModel extends _$TransactionHistoryViewModel {
  @override
  AsyncValue<List<Transaction>> build();
  
  Future<void> refreshHistory();
}
```

### 3. UI Components (View Layer)

#### Main Layout
- **AppShell**: Ana layout container
- **NavigationRail**: Sol taraf navigasyon
- **ContentArea**: Ana içerik alanı

#### Core Widgets
- **WalletConnectionWidget**: Cüzdan bağlantı durumu ve kontrolleri
- **BalanceDisplayWidget**: Bakiye gösterimi
- **TransferFormWidget**: Token transfer formu
- **TransactionHistoryWidget**: İşlem geçmişi listesi
- **LoadingWidget**: Yükleme göstergesi
- **ErrorWidget**: Hata mesajları

## Data Models

### WalletState
```dart
@freezed
class WalletState with _$WalletState {
  const factory WalletState.initial() = _Initial;
  const factory WalletState.connecting() = _Connecting;
  const factory WalletState.connected({
    required EthereumAddress address,
    required EtherAmount balance,
  }) = _Connected;
  const factory WalletState.disconnected() = _Disconnected;
  const factory WalletState.error(String message) = _Error;
}
```

### TransferState
```dart
@freezed
class TransferState with _$TransferState {
  const factory TransferState.initial() = _Initial;
  const factory TransferState.loading() = _Loading;
  const factory TransferState.success(String transactionHash) = _Success;
  const factory TransferState.error(String message) = _Error;
}
```

### Transaction Model
```dart
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String hash,
    required EthereumAddress from,
    required EthereumAddress to,
    required EtherAmount value,
    required DateTime timestamp,
    required TransactionStatus status,
  }) = _Transaction;
}
```

## Error Handling

### Error Types
1. **NetworkError**: Ağ bağlantı hataları
2. **WalletError**: Cüzdan bağlantı/işlem hataları
3. **ValidationError**: Form validasyon hataları
4. **BlockchainError**: Blockchain işlem hataları

### Error Handling Strategy
```dart
@riverpod
class ErrorHandlerViewModel extends _$ErrorHandlerViewModel {
  @override
  ErrorState build() => const ErrorState.none();
  
  void handleError(Object error, StackTrace stackTrace) {
    if (error is WalletException) {
      state = ErrorState.wallet(error.message);
    } else if (error is NetworkException) {
      state = ErrorState.network(error.message);
    } else {
      state = ErrorState.unknown(error.toString());
    }
  }
}
```

## Testing Strategy

### Unit Tests
- **Service Layer**: Web3Service, WalletService test coverage
- **ViewModel Layer**: Riverpod provider'ları için test
- **Model Layer**: Data model serialization/deserialization

### Widget Tests
- **UI Components**: Her widget için isolated test
- **Integration**: Widget ve ViewModel etkileşimi

### Integration Tests
- **End-to-End**: Tam kullanıcı akışları
- **Mock Services**: Blockchain servisleri için mock implementasyonlar

### Test Structure
```
test/
├── unit/
│   ├── services/
│   ├── viewmodels/
│   └── models/
├── widget/
│   └── widgets/
└── integration/
    └── flows/
```

## Security Considerations

1. **Private Key Management**: Cüzdan extension'ları üzerinden, uygulama private key saklamaz
2. **Input Validation**: Tüm kullanıcı girdileri validate edilir
3. **Transaction Verification**: İşlemler gönderilmeden önce doğrulanır
4. **Error Information**: Hassas bilgiler hata mesajlarında gösterilmez

## Performance Optimizations

1. **Lazy Loading**: Sayfa bazlı lazy loading
2. **Caching**: Blockchain verilerini geçici cache'leme
3. **Debouncing**: Kullanıcı input'ları için debounce
4. **Connection Pooling**: Web3 bağlantıları için pool yönetimi

## Deployment Configuration

### Web Configuration
- **CORS Settings**: Monad RPC endpoint'leri için
- **Environment Variables**: Network configuration
- **Build Optimization**: Flutter web build optimizasyonları