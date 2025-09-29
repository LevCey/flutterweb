import 'dart:async';
import 'dart:html' as html;

/// Web platform implementation for wallet service
class WalletServicePlatform {
  /// Checks if a wallet extension is available in the browser
  bool isWalletAvailable() {
    try {
      return html.window.hasProperty('ethereum');
    } catch (e) {
      return false;
    }
  }

  /// Requests account access from the wallet
  Future<List<String>> requestAccounts() async {
    try {
      final ethereum = html.window['ethereum'];
      if (ethereum == null) {
        throw Exception('Ethereum object not found');
      }

      // Call eth_requestAccounts method
      final result = await _callEthereumMethod('eth_requestAccounts', []);

      if (result is List) {
        return result.cast<String>();
      }

      throw Exception('Invalid response from wallet');
    } catch (e) {
      throw Exception('Failed to request accounts: ${e.toString()}');
    }
  }

  /// Gets current accounts from the wallet
  Future<List<String>> getAccounts() async {
    try {
      final result = await _callEthereumMethod('eth_accounts', []);

      if (result is List) {
        return result.cast<String>();
      }

      return [];
    } catch (e) {
      return [];
    }
  }

  /// Listens for account changes in the wallet
  void listenToAccountChanges(Function(List<String>) onAccountChanged) {
    try {
      final ethereum = html.window['ethereum'];
      if (ethereum == null) return;

      // Listen for accountsChanged event
      ethereum.callMethod('on', [
        'accountsChanged',
        (accounts) {
          if (accounts is List) {
            onAccountChanged(accounts.cast<String>());
          }
        },
      ]);

      // Listen for chainChanged event
      ethereum.callMethod('on', [
        'chainChanged',
        (chainId) {
          // Handle chain changes if needed
        },
      ]);
    } catch (e) {
      // Ignore errors in event listening setup
    }
  }

  /// Calls a method on the ethereum object
  Future<dynamic> _callEthereumMethod(
    String method,
    List<dynamic> params,
  ) async {
    final completer = Completer<dynamic>();

    try {
      final ethereum = html.window['ethereum'];
      if (ethereum == null) {
        throw Exception('Ethereum object not found');
      }

      // Create request object
      final request = {'method': method, 'params': params};

      // Call the method and handle the promise
      final promise = ethereum.callMethod('request', [request]);

      // Convert JS Promise to Dart Future
      promise
          .callMethod('then', [(result) => completer.complete(result)])
          .callMethod('catch', [
            (error) => completer.completeError(Exception(error.toString())),
          ]);
    } catch (e) {
      completer.completeError(Exception(e.toString()));
    }

    return completer.future;
  }
}
