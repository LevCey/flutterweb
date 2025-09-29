import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web3dart/web3dart.dart';
import '../models/transfer_state.dart';
import '../models/wallet_state.dart';
import '../services/wallet_service.dart';
import '../services/web3_service.dart';
import 'wallet_viewmodel.dart';

part 'transfer_viewmodel.g.dart';

/// Riverpod AsyncNotifier for transfer operations
/// Handles form validation, state management, and token sending functionality
@riverpod
class TransferViewModel extends _$TransferViewModel {
  WalletService? _walletService;
  Web3Service? _web3Service;

  // Form fields
  String _recipientAddress = '';
  String _amount = '';

  @override
  TransferState build() {
    // Get services from providers
    _walletService = ref.read(walletServiceProvider);
    _web3Service = ref.read(web3ServiceProvider);

    return const TransferState.initial();
  }

  /// Updates the recipient address field
  void updateRecipient(String address) {
    _recipientAddress = address.trim();
    _validateAndUpdateState();
  }

  /// Updates the amount field
  void updateAmount(String amount) {
    _amount = amount.trim();
    _validateAndUpdateState();
  }

  /// Gets the current recipient address
  String get recipientAddress => _recipientAddress;

  /// Gets the current amount
  String get amount => _amount;

  /// Validates the current form data and returns validation errors
  Map<String, String> validateForm() {
    final errors = <String, String>{};

    // Validate recipient address
    if (_recipientAddress.isEmpty) {
      errors['recipient'] = 'Recipient address is required';
    } else if (!TransferValidation.isValidAddress(_recipientAddress)) {
      errors['recipient'] = 'Invalid Ethereum address format';
    }

    // Validate amount
    if (_amount.isEmpty) {
      errors['amount'] = 'Amount is required';
    } else if (!TransferValidation.isValidAmount(_amount)) {
      errors['amount'] = 'Invalid amount format';
    } else {
      // Check if amount is within balance
      final walletState = ref.read(walletViewModelProvider);
      walletState.whenOrNull(
        connected: (address, balance) {
          if (!TransferValidation.isAmountWithinBalance(_amount, balance)) {
            errors['amount'] = 'Amount exceeds available balance';
          }
        },
      );
    }

    return errors;
  }

  /// Checks if the form is valid
  bool get isFormValid {
    return validateForm().isEmpty;
  }

  /// Sends tokens to the specified recipient
  /// Updates state through loading, success, or error states
  Future<void> sendTokens(String toAddress, double amount) async {
    try {
      // Validate inputs
      if (!TransferValidation.isValidAddress(toAddress)) {
        state = TransferState.error(
          message: 'Invalid recipient address',
          recipient: TransferValidation.createEthereumAddress(toAddress),
          amount: TransferValidation.createEtherAmount(amount.toString()),
        );
        return;
      }

      if (amount <= 0) {
        state = TransferState.error(
          message: 'Amount must be greater than zero',
          recipient: TransferValidation.createEthereumAddress(toAddress),
          amount: TransferValidation.createEtherAmount(amount.toString()),
        );
        return;
      }

      // Get wallet state to ensure we're connected
      final walletState = ref.read(walletViewModelProvider);
      EthereumAddress? fromAddress;
      EtherAmount? currentBalance;

      walletState.when(
        initial: () => throw Exception('Wallet not connected'),
        connecting: () => throw Exception('Wallet connection in progress'),
        connected: (address, balance) {
          fromAddress = address;
          currentBalance = balance;
        },
        disconnected: () => throw Exception('Wallet not connected'),
        error: (message) => throw Exception('Wallet error: $message'),
      );

      if (fromAddress == null) {
        throw Exception('No wallet connected');
      }

      final recipient = EthereumAddress.fromHex(toAddress);
      final transferAmount = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from((amount * 1e18).round()),
      );

      // Check balance
      if (currentBalance != null &&
          transferAmount.getInWei > currentBalance!.getInWei) {
        state = TransferState.error(
          message: 'Insufficient balance',
          recipient: recipient,
          amount: transferAmount,
        );
        return;
      }

      // Update state to loading
      state = TransferState.loading(
        recipient: recipient,
        amount: transferAmount,
      );

      // Send transaction
      final txHash = await _web3Service!.sendTransaction(
        from: fromAddress!,
        to: recipient,
        value: transferAmount,
        credentials:
            _createDummyCredentials(), // In real app, this would come from wallet
      );

      // Update state to success
      state = TransferState.success(
        transactionHash: txHash,
        recipient: recipient,
        amount: transferAmount,
      );

      // Clear form after successful transfer
      _clearForm();

      // Refresh wallet balance
      await ref.read(walletViewModelProvider.notifier).refreshBalance();
    } catch (e) {
      final recipient = TransferValidation.createEthereumAddress(toAddress);
      final transferAmount = TransferValidation.createEtherAmount(
        amount.toString(),
      );

      state = TransferState.error(
        message: 'Transfer failed: ${e.toString()}',
        recipient: recipient,
        amount: transferAmount,
      );
    }
  }

  /// Sends tokens using the current form values
  Future<void> sendTokensFromForm() async {
    if (!isFormValid) {
      final errors = validateForm();
      final errorMessage = errors.values.first;

      state = TransferState.error(
        message: errorMessage,
        recipient: TransferValidation.createEthereumAddress(_recipientAddress),
        amount: TransferValidation.createEtherAmount(_amount),
      );
      return;
    }

    final amount = double.tryParse(_amount);
    if (amount == null) {
      state = TransferState.error(
        message: 'Invalid amount format',
        recipient: TransferValidation.createEthereumAddress(_recipientAddress),
        amount: null,
      );
      return;
    }

    await sendTokens(_recipientAddress, amount);
  }

  /// Resets the transfer state to initial
  void resetState() {
    state = const TransferState.initial();
  }

  /// Clears the form fields
  void clearForm() {
    _clearForm();
    state = const TransferState.initial();
  }

  /// Private helper to clear form fields
  void _clearForm() {
    _recipientAddress = '';
    _amount = '';
  }

  /// Private helper to validate form and update state if needed
  void _validateAndUpdateState() {
    // Only update state if we're in initial state and form becomes valid
    if (state == const TransferState.initial() && isFormValid) {
      // Keep in initial state but form is ready
      return;
    }

    // If we're in error state and form becomes valid, reset to initial
    state.whenOrNull(
      error: (message, recipient, amount) {
        if (isFormValid) {
          state = const TransferState.initial();
        }
      },
    );
  }

  /// Creates dummy credentials for testing
  /// In a real app, this would be handled by the wallet extension
  Credentials _createDummyCredentials() {
    // This is a placeholder - in real implementation,
    // the wallet extension would handle signing
    return EthPrivateKey.fromHex(
      '0x0000000000000000000000000000000000000000000000000000000000000001',
    );
  }

  /// Gets the current transfer status
  String get transferStatus {
    return state.when(
      initial: () => 'Ready',
      loading: (recipient, amount) => 'Sending...',
      success: (hash, recipient, amount) => 'Success',
      error: (message, recipient, amount) => 'Error',
    );
  }

  /// Checks if transfer is in progress
  bool get isTransferInProgress {
    return state.isTransferInProgress;
  }

  /// Gets the transaction hash if transfer was successful
  String? get transactionHash {
    return state.transactionHash;
  }

  /// Gets the error message if transfer failed
  String? get errorMessage {
    return state.errorMessage;
  }
}
