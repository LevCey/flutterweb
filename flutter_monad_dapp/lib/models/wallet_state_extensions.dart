import 'package:web3dart/web3dart.dart';
import 'wallet_state.dart';

/// Extension methods for WalletState to provide convenient getters
extension WalletStateX on WalletState {
  /// Returns true if wallet is currently connected
  bool get isConnected =>
      maybeWhen(connected: (_, __) => true, orElse: () => false);

  /// Returns true if wallet is in connecting state
  bool get isConnecting =>
      maybeWhen(connecting: () => true, orElse: () => false);

  /// Returns true if there's an error
  bool get hasError => maybeWhen(error: (_) => true, orElse: () => false);

  /// Returns the connected address if available
  EthereumAddress? get connectedAddress =>
      maybeWhen(connected: (address, _) => address, orElse: () => null);

  /// Returns the current balance if available
  EtherAmount? get currentBalance =>
      maybeWhen(connected: (_, balance) => balance, orElse: () => null);

  /// Returns the error message if in error state
  String? get errorMessage =>
      maybeWhen(error: (message) => message, orElse: () => null);

  /// Returns a formatted address string (shortened)
  String? get formattedAddress {
    final addr = connectedAddress;
    if (addr == null) return null;
    final hexAddr = addr.hex;
    if (hexAddr.length <= 10) return hexAddr;
    return '${hexAddr.substring(0, 6)}...${hexAddr.substring(hexAddr.length - 4)}';
  }

  /// Returns balance in Ether as a formatted string
  String? get formattedBalance {
    final balance = currentBalance;
    if (balance == null) return null;
    return '${balance.getValueInUnit(EtherUnit.ether).toStringAsFixed(4)} ETH';
  }
}
