import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3dart/web3dart.dart';
import '../models/wallet_state.dart';
import '../services/wallet_service.dart';
import '../services/web3_service.dart';

part 'wallet_viewmodel.g.dart';

/// Riverpod AsyncNotifier for wallet state management
/// Handles wallet connection, disconnection, and balance refresh functionality
@riverpod
class WalletViewModel extends _$WalletViewModel {
  WalletService? _walletService;
  Web3Service? _web3Service;

  @override
  WalletState build() {
    // Get services from providers
    _walletService = ref.read(walletServiceProvider);
    _web3Service = ref.read(web3ServiceProvider);

    return const WalletState.initial();
  }

  /// Attempts to connect to a wallet (MetaMask or similar)
  /// Updates state to connecting, then connected or error based on result
  Future<void> connectWallet() async {
    try {
      state = const WalletState.connecting();

      final success = await _walletService!.connectWallet();

      if (success) {
        // Get the connected address and refresh balance
        final address = await _walletService!.getConnectedAddress();
        if (address != null) {
          await _refreshBalanceForAddress(address);
        }
      } else {
        state = const WalletState.error('Failed to connect wallet');
      }
    } catch (e) {
      state = WalletState.error('Failed to connect wallet: ${e.toString()}');
    }
  }

  /// Disconnects the current wallet
  /// Updates state to disconnected
  Future<void> disconnectWallet() async {
    try {
      await _walletService!.disconnectWallet();
      state = const WalletState.disconnected();
    } catch (e) {
      state = WalletState.error('Failed to disconnect wallet: ${e.toString()}');
    }
  }

  /// Refreshes the balance for the currently connected wallet
  /// Only works if wallet is in connected state
  Future<void> refreshBalance() async {
    final currentState = state;

    currentState.whenOrNull(
      connected: (address, balance) async {
        try {
          await _refreshBalanceForAddress(address);
        } catch (e) {
          state = WalletState.error(
            'Failed to refresh balance: ${e.toString()}',
          );
        }
      },
    );
  }

  /// Private helper method to refresh balance for a specific address
  Future<void> _refreshBalanceForAddress(EthereumAddress address) async {
    try {
      final balance = await _web3Service!.getBalance(address);
      state = WalletState.connected(address: address, balance: balance);

      // Also update the wallet service with the new balance
      await _walletService!.updateBalance(balance);
    } catch (e) {
      state = WalletState.error('Failed to get balance: ${e.toString()}');
    }
  }

  /// Gets the currently connected wallet address
  /// Returns null if no wallet is connected
  EthereumAddress? get connectedAddress {
    return state.whenOrNull(connected: (address, balance) => address);
  }

  /// Gets the current wallet balance
  /// Returns null if no wallet is connected
  EtherAmount? get currentBalance {
    return state.whenOrNull(connected: (address, balance) => balance);
  }

  /// Checks if wallet is currently connected
  bool get isConnected {
    return state.whenOrNull(connected: (address, balance) => true) ?? false;
  }

  /// Checks if wallet connection is in progress
  bool get isConnecting {
    return state.whenOrNull(connecting: () => true) ?? false;
  }

  /// Gets the current error message if any
  String? get errorMessage {
    return state.whenOrNull(error: (message) => message);
  }
}

/// Provider for accessing the WalletService instance
@riverpod
WalletService walletService(WalletServiceRef ref) {
  final service = WalletService();
  ref.onDispose(() => service.dispose());
  return service;
}

/// Provider for accessing the Web3Service instance
@riverpod
Web3Service web3Service(Web3ServiceRef ref) {
  final service = Web3Service();
  ref.onDispose(() => service.dispose());
  return service;
}
