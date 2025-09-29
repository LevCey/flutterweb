import 'dart:async';

/// Stub implementation for non-web platforms (used in testing)
class WalletServicePlatform {
  /// Checks if a wallet extension is available
  bool isWalletAvailable() {
    return false; // No wallet available in non-web platforms
  }

  /// Requests account access from the wallet
  Future<List<String>> requestAccounts() async {
    throw Exception('Wallet not available on this platform');
  }

  /// Gets current accounts from the wallet
  Future<List<String>> getAccounts() async {
    return [];
  }

  /// Listens for account changes in the wallet
  void listenToAccountChanges(Function(List<String>) onAccountChanged) {
    // No-op for non-web platforms
  }
}
