import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/json_converters.dart';

part 'transfer_state.freezed.dart';
part 'transfer_state.g.dart';

/// Represents the different states of token transfer operations
/// This is a union type using Freezed for immutable state management
@freezed
class TransferState with _$TransferState {
  /// Initial state when no transfer operation has been initiated
  const factory TransferState.initial() = _Initial;

  /// State when a transfer operation is in progress
  const factory TransferState.loading({
    @EthereumAddressConverter() required EthereumAddress recipient,
    @EtherAmountConverter() required EtherAmount amount,
  }) = _Loading;

  /// State when transfer operation completed successfully
  const factory TransferState.success({
    required String transactionHash,
    @EthereumAddressConverter() required EthereumAddress recipient,
    @EtherAmountConverter() required EtherAmount amount,
  }) = _Success;

  /// State when transfer operation failed or was rejected
  const factory TransferState.error({
    required String message,
    @EthereumAddressConverter() EthereumAddress? recipient,
    @EtherAmountConverter() EtherAmount? amount,
  }) = _Error;

  /// JSON serialization support
  factory TransferState.fromJson(Map<String, dynamic> json) =>
      _$TransferStateFromJson(json);
}

/// Extension methods for TransferState validation and utility functions
extension TransferStateExtensions on TransferState {
  /// Validates if the current state has valid transfer data
  bool get hasValidTransferData {
    return when(
      initial: () => false,
      loading: (recipient, amount) => _isValidTransferData(recipient, amount),
      success: (hash, recipient, amount) =>
          _isValidTransferData(recipient, amount),
      error: (message, recipient, amount) =>
          recipient != null &&
          amount != null &&
          _isValidTransferData(recipient, amount),
    );
  }

  /// Gets the recipient address if available
  EthereumAddress? get recipient {
    return when(
      initial: () => null,
      loading: (recipient, amount) => recipient,
      success: (hash, recipient, amount) => recipient,
      error: (message, recipient, amount) => recipient,
    );
  }

  /// Gets the transfer amount if available
  EtherAmount? get amount {
    return when(
      initial: () => null,
      loading: (recipient, amount) => amount,
      success: (hash, recipient, amount) => amount,
      error: (message, recipient, amount) => amount,
    );
  }

  /// Checks if the state represents an active transfer operation
  bool get isTransferInProgress {
    return when(
      initial: () => false,
      loading: (recipient, amount) => true,
      success: (hash, recipient, amount) => false,
      error: (message, recipient, amount) => false,
    );
  }

  /// Gets the transaction hash if the transfer was successful
  String? get transactionHash {
    return when(
      initial: () => null,
      loading: (recipient, amount) => null,
      success: (hash, recipient, amount) => hash,
      error: (message, recipient, amount) => null,
    );
  }

  /// Gets the error message if the transfer failed
  String? get errorMessage {
    return when(
      initial: () => null,
      loading: (recipient, amount) => null,
      success: (hash, recipient, amount) => null,
      error: (message, recipient, amount) => message,
    );
  }

  /// Private helper method to validate transfer data
  bool _isValidTransferData(EthereumAddress recipient, EtherAmount amount) {
    // Check if recipient address is valid (not zero address)
    if (recipient.hex == '0x0000000000000000000000000000000000000000') {
      return false;
    }

    // Check if amount is positive
    if (amount.getInWei <= BigInt.zero) {
      return false;
    }

    return true;
  }
}

/// Validation methods for transfer data
class TransferValidation {
  /// Validates an Ethereum address string
  static bool isValidAddress(String address) {
    try {
      final ethAddress = EthereumAddress.fromHex(address);
      // Check if it's not the zero address
      return ethAddress.hex != '0x0000000000000000000000000000000000000000';
    } catch (e) {
      return false;
    }
  }

  /// Validates a transfer amount string
  static bool isValidAmount(String amount) {
    try {
      final double parsedAmount = double.parse(amount);
      return parsedAmount > 0;
    } catch (e) {
      return false;
    }
  }

  /// Validates if the amount doesn't exceed the available balance
  static bool isAmountWithinBalance(String amount, EtherAmount balance) {
    try {
      final double parsedAmount = double.parse(amount);
      // Convert ether to wei (1 ETH = 10^18 wei)
      final BigInt weiAmount = BigInt.from((parsedAmount * 1e18).round());
      final EtherAmount transferAmount = EtherAmount.fromBigInt(
        EtherUnit.wei,
        weiAmount,
      );
      return transferAmount.getInWei <= balance.getInWei;
    } catch (e) {
      return false;
    }
  }

  /// Creates an EtherAmount from a string value
  static EtherAmount? createEtherAmount(String amount) {
    try {
      final double parsedAmount = double.parse(amount);
      // Convert ether to wei (1 ETH = 10^18 wei)
      final BigInt weiAmount = BigInt.from((parsedAmount * 1e18).round());
      return EtherAmount.fromBigInt(EtherUnit.wei, weiAmount);
    } catch (e) {
      return null;
    }
  }

  /// Creates an EthereumAddress from a string
  static EthereumAddress? createEthereumAddress(String address) {
    try {
      return EthereumAddress.fromHex(address);
    } catch (e) {
      return null;
    }
  }
}
