import 'package:flutter_test/flutter_test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_monad_dapp/models/transaction.dart' as app_models;
import 'package:flutter_monad_dapp/models/transaction_status.dart';

void main() {
  group('Transaction Model Tests', () {
    late EthereumAddress fromAddress;
    late EthereumAddress toAddress;
    late EtherAmount value;
    late DateTime timestamp;
    late app_models.Transaction testTransaction;

    setUp(() {
      fromAddress = EthereumAddress.fromHex(
        '0x1234567890123456789012345678901234567890',
      );
      toAddress = EthereumAddress.fromHex(
        '0x0987654321098765432109876543210987654321',
      );
      value = EtherAmount.fromBigInt(EtherUnit.ether, BigInt.from(1));
      timestamp = DateTime.parse('2024-01-01T12:00:00Z');

      testTransaction = app_models.Transaction(
        hash:
            '0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890',
        from: fromAddress,
        to: toAddress,
        value: value,
        timestamp: timestamp,
        status: TransactionStatus.confirmed,
        blockNumber: 12345,
        gasUsed: BigInt.from(21000),
        gasPrice: EtherAmount.fromBigInt(EtherUnit.gwei, BigInt.from(20)),
      );
    });

    test('should create Transaction with required fields', () {
      final transaction = app_models.Transaction(
        hash: '0xtest',
        from: fromAddress,
        to: toAddress,
        value: value,
        timestamp: timestamp,
        status: TransactionStatus.pending,
      );

      expect(transaction.hash, equals('0xtest'));
      expect(transaction.from, equals(fromAddress));
      expect(transaction.to, equals(toAddress));
      expect(transaction.value, equals(value));
      expect(transaction.timestamp, equals(timestamp));
      expect(transaction.status, equals(TransactionStatus.pending));
      expect(transaction.blockNumber, isNull);
      expect(transaction.gasUsed, isNull);
      expect(transaction.gasPrice, isNull);
    });

    test('should create Transaction with all optional fields', () {
      expect(
        testTransaction.hash,
        equals(
          '0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890',
        ),
      );
      expect(testTransaction.from, equals(fromAddress));
      expect(testTransaction.to, equals(toAddress));
      expect(testTransaction.value, equals(value));
      expect(testTransaction.timestamp, equals(timestamp));
      expect(testTransaction.status, equals(TransactionStatus.confirmed));
      expect(testTransaction.blockNumber, equals(12345));
      expect(testTransaction.gasUsed, equals(BigInt.from(21000)));
      expect(
        testTransaction.gasPrice,
        equals(EtherAmount.fromBigInt(EtherUnit.gwei, BigInt.from(20))),
      );
    });

    group('JSON Serialization', () {
      test('should serialize to JSON correctly', () {
        final json = testTransaction.toJson();

        expect(
          json['hash'],
          equals(
            '0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890',
          ),
        );
        expect(json['from'], equals(fromAddress.hex));
        expect(json['to'], equals(toAddress.hex));
        expect(json['value'], equals(value.getInWei.toString()));
        expect(json['timestamp'], equals(timestamp.toIso8601String()));
        expect(json['status'], equals('confirmed'));
        expect(json['block_number'], equals(12345));
        expect(json['gas_used'], equals('21000'));
        expect(
          json['gas_price'],
          equals(
            EtherAmount.fromBigInt(
              EtherUnit.gwei,
              BigInt.from(20),
            ).getInWei.toString(),
          ),
        );
      });

      test('should deserialize from JSON correctly', () {
        final json = {
          'hash':
              '0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890',
          'from': fromAddress.hex,
          'to': toAddress.hex,
          'value': value.getInWei.toString(),
          'timestamp': timestamp.toIso8601String(),
          'status': 'confirmed',
          'block_number': 12345,
          'gas_used': '21000',
          'gas_price': EtherAmount.fromBigInt(
            EtherUnit.gwei,
            BigInt.from(20),
          ).getInWei.toString(),
        };

        final transaction = app_models.Transaction.fromJson(json);

        expect(
          transaction.hash,
          equals(
            '0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890',
          ),
        );
        expect(transaction.from, equals(fromAddress));
        expect(transaction.to, equals(toAddress));
        expect(transaction.value.getInWei, equals(value.getInWei));
        expect(transaction.timestamp, equals(timestamp));
        expect(transaction.status, equals(TransactionStatus.confirmed));
        expect(transaction.blockNumber, equals(12345));
        expect(transaction.gasUsed, equals(BigInt.from(21000)));
        expect(
          transaction.gasPrice!.getInWei,
          equals(
            EtherAmount.fromBigInt(EtherUnit.gwei, BigInt.from(20)).getInWei,
          ),
        );
      });

      test('should handle JSON with null optional fields', () {
        final json = {
          'hash': '0xtest',
          'from': fromAddress.hex,
          'to': toAddress.hex,
          'value': value.getInWei.toString(),
          'timestamp': timestamp.toIso8601String(),
          'status': 'pending',
        };

        final transaction = app_models.Transaction.fromJson(json);

        expect(transaction.hash, equals('0xtest'));
        expect(transaction.from, equals(fromAddress));
        expect(transaction.to, equals(toAddress));
        expect(transaction.value.getInWei, equals(value.getInWei));
        expect(transaction.timestamp, equals(timestamp));
        expect(transaction.status, equals(TransactionStatus.pending));
        expect(transaction.blockNumber, isNull);
        expect(transaction.gasUsed, isNull);
        expect(transaction.gasPrice, isNull);
      });
    });

    group('Extension Methods', () {
      test('shortHash should return shortened hash', () {
        expect(testTransaction.shortHash, equals('0xabcd...7890'));
      });

      test('shortHash should return full hash if length <= 10', () {
        final shortTransaction = testTransaction.copyWith(hash: '0x123456');
        expect(shortTransaction.shortHash, equals('0x123456'));
      });

      test(
        'transactionFee should calculate correctly when gas data available',
        () {
          final fee = testTransaction.transactionFee;
          expect(fee, isNotNull);
          expect(
            fee!.getInWei,
            equals(
              BigInt.from(21000) *
                  EtherAmount.fromBigInt(
                    EtherUnit.gwei,
                    BigInt.from(20),
                  ).getInWei,
            ),
          );
        },
      );

      test('transactionFee should return null when gas data not available', () {
        final transactionWithoutGas = testTransaction.copyWith(
          gasUsed: null,
          gasPrice: null,
        );
        expect(transactionWithoutGas.transactionFee, isNull);
      });

      test('involvesAddress should return true for from address', () {
        expect(testTransaction.involvesAddress(fromAddress), isTrue);
      });

      test('involvesAddress should return true for to address', () {
        expect(testTransaction.involvesAddress(toAddress), isTrue);
      });

      test('involvesAddress should return false for unrelated address', () {
        final unrelatedAddress = EthereumAddress.fromHex(
          '0x1111111111111111111111111111111111111111',
        );
        expect(testTransaction.involvesAddress(unrelatedAddress), isFalse);
      });

      test('isOutgoing should return true for from address', () {
        expect(testTransaction.isOutgoing(fromAddress), isTrue);
      });

      test('isOutgoing should return false for to address', () {
        expect(testTransaction.isOutgoing(toAddress), isFalse);
      });

      test('isIncoming should return true for to address', () {
        expect(testTransaction.isIncoming(toAddress), isTrue);
      });

      test('isIncoming should return false for from address', () {
        expect(testTransaction.isIncoming(fromAddress), isFalse);
      });
    });

    group('Freezed Functionality', () {
      test('should support copyWith', () {
        final updatedTransaction = testTransaction.copyWith(
          status: TransactionStatus.failed,
          blockNumber: 54321,
        );

        expect(updatedTransaction.status, equals(TransactionStatus.failed));
        expect(updatedTransaction.blockNumber, equals(54321));
        expect(updatedTransaction.hash, equals(testTransaction.hash));
        expect(updatedTransaction.from, equals(testTransaction.from));
        expect(updatedTransaction.to, equals(testTransaction.to));
      });

      test('should support equality comparison', () {
        final transaction1 = app_models.Transaction(
          hash: '0xtest',
          from: fromAddress,
          to: toAddress,
          value: value,
          timestamp: timestamp,
          status: TransactionStatus.pending,
        );

        final transaction2 = app_models.Transaction(
          hash: '0xtest',
          from: fromAddress,
          to: toAddress,
          value: value,
          timestamp: timestamp,
          status: TransactionStatus.pending,
        );

        expect(transaction1, equals(transaction2));
        expect(transaction1.hashCode, equals(transaction2.hashCode));
      });

      test('should support toString', () {
        final transaction = app_models.Transaction(
          hash: '0xtest',
          from: fromAddress,
          to: toAddress,
          value: value,
          timestamp: timestamp,
          status: TransactionStatus.pending,
        );

        final stringRepresentation = transaction.toString();
        expect(stringRepresentation, contains('Transaction'));
        expect(stringRepresentation, contains('0xtest'));
        expect(stringRepresentation, contains('pending'));
      });
    });
  });
}
