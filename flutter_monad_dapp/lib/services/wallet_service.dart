import 'dart:async';
import 'package:web3dart/web3dart.dart';
import '../models/wallet_state.dart';

// Conditional import for web platform
import 'wallet_service_web.dart'
    if (dart.library.io) 'wallet_service_stub.dart';

/// Service for managing wallet connections and state
/// Handles wallet connection/disconnection, address validation,
/// and provides real-time wallet state updates
class WalletService {
  final StreamController<WalletState> _stateController =
      StreamController<WalletState>.broadcast();

  WalletState _currentState = const WalletState.initial();
  EthereumAddress? _connectedAddress;
  late final WalletServicePlatform _platform;

  WalletService() {
    _platform = WalletServicePlatform();
  }

  /// Stream of wallet connection state changes
  Stream<WalletState> get connectionStream => _stateController.stream;

  /// Current wallet state
  WalletState get currentState => _currentState;

  /// Currently connected wallet address (if any)
  EthereumAddress? get connectedAddress => _connectedAddress;

  /// Attempts to connect to a wallet (MetaMask or similar)
  /// Returns true if connection is successful, false otherwise
  Future<bool> connectWallet() async {
    try {
      _updateState(const WalletState.connecting());

      // Check if ethereum object exists (MetaMask or similar wallet)
      if (!_platform.isWalletAvailable()) {
        throw WalletException(
          'No wallet extension found. Please install MetaMask or similar wallet.',
        );
      }

      // Request account access
      final accounts = await _platform.requestAccounts();

      if (accounts.isEmpty) {
        throw WalletException('No accounts found. Please unlock your wallet.');
      }

      final address = EthereumAddress.fromHex(accounts.first);
      _connectedAddress = address;

      // Get initial balance (this would typically use Web3Service)
      final balance =
          EtherAmount.zero(); // Placeholder - would get real balance

      _updateState(WalletState.connected(address: address, balance: balance));

      // Listen for account changes
      _platform.listenToAccountChanges(_onAccountChanged);

      return true;
    } catch (e) {
      final errorMessage = e is WalletException
          ? e.message
          : 'Failed to connect wallet: ${e.toString()}';
      _updateState(WalletState.error(errorMessage));
      return false;
    }
  }

  /// Disconnects the current wallet
  Future<void> disconnectWallet() async {
    try {
      _connectedAddress = null;
      _updateState(const WalletState.disconnected());
    } catch (e) {
      _updateState(
        WalletState.error('Failed to disconnect wallet: ${e.toString()}'),
      );
    }
  }

  /// Gets the currently connected wallet address
  /// Returns null if no wallet is connected
  Future<EthereumAddress?> getConnectedAddress() async {
    if (_connectedAddress != null) {
      return _connectedAddress;
    }

    // Try to get address from wallet if available
    try {
      if (_platform.isWalletAvailable()) {
        final accounts = await _platform.getAccounts();
        if (accounts.isNotEmpty) {
          _connectedAddress = EthereumAddress.fromHex(accounts.first);
          return _connectedAddress;
        }
      }
    } catch (e) {
      // Ignore errors when checking for existing connection
    }

    return null;
  }

  /// Updates the wallet balance in the current state
  Future<void> updateBalance(EtherAmount newBalance) async {
    _currentState.whenOrNull(
      connected: (address, balance) {
        _updateState(
          WalletState.connected(address: address, balance: newBalance),
        );
      },
    );
  }

  /// Validates if an Ethereum address is properly formatted
  static bool isValidAddress(String address) {
    try {
      EthereumAddress.fromHex(address);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Formats an Ethereum address for display (shortened version)
  static String formatAddress(
    EthereumAddress address, {
    int prefixLength = 6,
    int suffixLength = 4,
  }) {
    final addressStr = address.hex;
    if (addressStr.length <= prefixLength + suffixLength) {
      return addressStr;
    }
    return '${addressStr.substring(0, prefixLength)}...${addressStr.substring(addressStr.length - suffixLength)}';
  }

  /// Formats an Ethereum address string for display
  static String formatAddressString(
    String address, {
    int prefixLength = 6,
    int suffixLength = 4,
  }) {
    if (!isValidAddress(address)) return address;
    return formatAddress(
      EthereumAddress.fromHex(address),
      prefixLength: prefixLength,
      suffixLength: suffixLength,
    );
  }

  /// Handles account changes from the wallet
  void _onAccountChanged(List<String> accounts) {
    if (accounts.isNotEmpty) {
      final newAddress = EthereumAddress.fromHex(accounts.first);
      if (newAddress != _connectedAddress) {
        _connectedAddress = newAddress;
        _updateState(
          WalletState.connected(
            address: newAddress,
            balance: EtherAmount.zero(), // Would get real balance
          ),
        );
      }
    } else {
      // No accounts available, disconnect
      disconnectWallet();
    }
  }

  /// Updates the current state and notifies listeners
  void _updateState(WalletState newState) {
    _currentState = newState;
    _stateController.add(newState);
  }

  /// Disposes of the service and closes streams
  void dispose() {
    _stateController.close();
  }
}

/// Custom exception for wallet-related errors
class WalletException implements Exception {
  final String message;

  const WalletException(this.message);

  @override
  String toString() => 'WalletException: $message';
}
