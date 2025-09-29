import 'dart:async';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';
import '../models/transaction.dart' as app_models;
import '../models/transaction_status.dart';

/// Service for interacting with the Monad blockchain
/// Handles Web3 client initialization, balance retrieval, transaction sending,
/// and transaction history fetching
class Web3Service {
  Web3Client? _client;
  final http.Client _httpClient = http.Client();

  /// Gets or creates a Web3Client instance for Monad network
  Future<Web3Client> getClient() async {
    _client ??= Web3Client(AppConstants.monadRpcUrl, _httpClient);
    return _client!;
  }

  /// Retrieves the balance for a given Ethereum address
  /// Returns the balance as EtherAmount
  Future<EtherAmount> getBalance(EthereumAddress address) async {
    try {
      final client = await getClient();
      return await client.getBalance(address);
    } catch (e) {
      throw Web3Exception('Failed to get balance: ${e.toString()}');
    }
  }

  /// Sends a transaction to the blockchain
  /// Returns the transaction hash as a string
  Future<String> sendTransaction({
    required EthereumAddress from,
    required EthereumAddress to,
    required EtherAmount value,
    required Credentials credentials,
    BigInt? gasPrice,
    int? gasLimit,
  }) async {
    try {
      final client = await getClient();

      final transaction = Transaction(
        from: from,
        to: to,
        value: value,
        gasPrice: gasPrice != null
            ? EtherAmount.fromBigInt(EtherUnit.wei, gasPrice)
            : EtherAmount.fromBigInt(
                EtherUnit.wei,
                BigInt.parse(AppConstants.defaultGasPrice),
              ),
        maxGas: gasLimit ?? AppConstants.defaultGasLimit,
      );

      final txHash = await client.sendTransaction(
        credentials,
        transaction,
        chainId: AppConstants.monadChainId,
      );

      return txHash;
    } catch (e) {
      throw Web3Exception('Failed to send transaction: ${e.toString()}');
    }
  }

  /// Retrieves transaction history for a given address
  /// Returns a list of Transaction models
  /// Note: This is a simplified implementation for demo purposes
  Future<List<app_models.Transaction>> getTransactionHistory(
    EthereumAddress address, {
    int limit = 10,
  }) async {
    try {
      // In a real implementation, you would use an indexing service
      // or event logs to get transaction history efficiently
      // For now, return an empty list as a placeholder
      return <app_models.Transaction>[];
    } catch (e) {
      throw Web3Exception('Failed to get transaction history: ${e.toString()}');
    }
  }

  /// Gets transaction details by hash
  Future<app_models.Transaction?> getTransactionByHash(String hash) async {
    try {
      final client = await getClient();
      final txInfo = await client.getTransactionByHash(hash);

      if (txInfo == null) return null;

      // Get block information for timestamp
      final receipt = await client.getTransactionReceipt(hash);
      final block = receipt != null
          ? await client.getBlockInformation(
              blockNumber: receipt.blockNumber.blockNum.toString(),
            )
          : null;

      return app_models.Transaction(
        hash: txInfo.hash,
        from: txInfo.from,
        to:
            txInfo.to ??
            EthereumAddress.fromHex(
              '0x0000000000000000000000000000000000000000',
            ),
        value: txInfo.value,
        timestamp: block?.timestamp ?? DateTime.now(),
        status: receipt != null
            ? (receipt.status!
                  ? TransactionStatus.confirmed
                  : TransactionStatus.failed)
            : TransactionStatus.pending,
        blockNumber: receipt?.blockNumber.blockNum,
        gasUsed: receipt?.gasUsed,
        gasPrice: txInfo.gasPrice,
      );
    } catch (e) {
      throw Web3Exception('Failed to get transaction: ${e.toString()}');
    }
  }

  /// Estimates gas for a transaction
  Future<BigInt> estimateGas({
    required EthereumAddress from,
    required EthereumAddress to,
    required EtherAmount value,
  }) async {
    try {
      final client = await getClient();

      return await client.estimateGas(sender: from, to: to, value: value);
    } catch (e) {
      throw Web3Exception('Failed to estimate gas: ${e.toString()}');
    }
  }

  /// Gets the current gas price from the network
  Future<EtherAmount> getGasPrice() async {
    try {
      final client = await getClient();
      return await client.getGasPrice();
    } catch (e) {
      throw Web3Exception('Failed to get gas price: ${e.toString()}');
    }
  }

  /// Disposes of the service and closes connections
  void dispose() {
    _client?.dispose();
    _httpClient.close();
  }
}

/// Custom exception for Web3 service errors
class Web3Exception implements Exception {
  final String message;

  const Web3Exception(this.message);

  @override
  String toString() => 'Web3Exception: $message';
}
