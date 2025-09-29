/// Enum representing the different states of a blockchain transaction
enum TransactionStatus {
  /// Transaction is pending confirmation on the blockchain
  pending,

  /// Transaction has been confirmed and included in a block
  confirmed,

  /// Transaction failed to execute
  failed,

  /// Transaction was dropped from the mempool
  dropped;

  /// Returns a human-readable string representation of the status
  String get displayName {
    switch (this) {
      case TransactionStatus.pending:
        return 'Pending';
      case TransactionStatus.confirmed:
        return 'Confirmed';
      case TransactionStatus.failed:
        return 'Failed';
      case TransactionStatus.dropped:
        return 'Dropped';
    }
  }

  /// Returns true if the transaction is in a final state (not pending)
  bool get isFinal {
    return this != TransactionStatus.pending;
  }

  /// Returns true if the transaction was successful
  bool get isSuccessful {
    return this == TransactionStatus.confirmed;
  }
}
