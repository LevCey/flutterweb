import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/json_converters.dart';
import 'transaction_status.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

/// Represents a blockchain transaction with all relevant information
/// This model is used to display transaction history and track transaction states
@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    /// Unique transaction hash on the blockchain
    required String hash,

    /// Address that sent the transaction
    @EthereumAddressConverter() required EthereumAddress from,

    /// Address that received the transaction
    @EthereumAddressConverter() required EthereumAddress to,

    /// Amount of tokens transferred
    @EtherAmountConverter() required EtherAmount value,

    /// Timestamp when the transaction was created/confirmed
    @DateTimeConverter() required DateTime timestamp,

    /// Current status of the transaction
    required TransactionStatus status,

    /// Optional block number where transaction was included
    int? blockNumber,

    /// Optional gas used by the transaction
    BigInt? gasUsed,

    /// Optional gas price used for the transaction
    @EtherAmountConverter() EtherAmount? gasPrice,
  }) = _Transaction;

  /// Creates a Transaction from JSON data (typically from API responses)
  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}

/// Extension methods for Transaction to provide additional functionality
extension TransactionExtensions on Transaction {
  /// Returns a shortened version of the transaction hash for display
  String get shortHash {
    if (hash.length <= 10) return hash;
    return '${hash.substring(0, 6)}...${hash.substring(hash.length - 4)}';
  }

  /// Returns the transaction fee (gasUsed * gasPrice) if available
  EtherAmount? get transactionFee {
    if (gasUsed != null && gasPrice != null) {
      return EtherAmount.fromBigInt(
        EtherUnit.wei,
        gasUsed! * gasPrice!.getInWei,
      );
    }
    return null;
  }

  /// Returns true if this transaction involves the given address
  bool involvesAddress(EthereumAddress address) {
    return from == address || to == address;
  }

  /// Returns true if this is an outgoing transaction from the given address
  bool isOutgoing(EthereumAddress address) {
    return from == address;
  }

  /// Returns true if this is an incoming transaction to the given address
  bool isIncoming(EthereumAddress address) {
    return to == address;
  }
}
