import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_monad_dapp/models/transaction_status.dart';

void main() {
  group('TransactionStatus Tests', () {
    test('should have correct enum values', () {
      expect(TransactionStatus.values.length, equals(4));
      expect(TransactionStatus.values, contains(TransactionStatus.pending));
      expect(TransactionStatus.values, contains(TransactionStatus.confirmed));
      expect(TransactionStatus.values, contains(TransactionStatus.failed));
      expect(TransactionStatus.values, contains(TransactionStatus.dropped));
    });

    group('displayName', () {
      test('should return correct display names', () {
        expect(TransactionStatus.pending.displayName, equals('Pending'));
        expect(TransactionStatus.confirmed.displayName, equals('Confirmed'));
        expect(TransactionStatus.failed.displayName, equals('Failed'));
        expect(TransactionStatus.dropped.displayName, equals('Dropped'));
      });
    });

    group('isFinal', () {
      test('should return false for pending status', () {
        expect(TransactionStatus.pending.isFinal, isFalse);
      });

      test('should return true for confirmed status', () {
        expect(TransactionStatus.confirmed.isFinal, isTrue);
      });

      test('should return true for failed status', () {
        expect(TransactionStatus.failed.isFinal, isTrue);
      });

      test('should return true for dropped status', () {
        expect(TransactionStatus.dropped.isFinal, isTrue);
      });
    });

    group('isSuccessful', () {
      test('should return false for pending status', () {
        expect(TransactionStatus.pending.isSuccessful, isFalse);
      });

      test('should return true for confirmed status', () {
        expect(TransactionStatus.confirmed.isSuccessful, isTrue);
      });

      test('should return false for failed status', () {
        expect(TransactionStatus.failed.isSuccessful, isFalse);
      });

      test('should return false for dropped status', () {
        expect(TransactionStatus.dropped.isSuccessful, isFalse);
      });
    });

    group('JSON Serialization', () {
      test('should serialize to string correctly', () {
        expect(TransactionStatus.pending.name, equals('pending'));
        expect(TransactionStatus.confirmed.name, equals('confirmed'));
        expect(TransactionStatus.failed.name, equals('failed'));
        expect(TransactionStatus.dropped.name, equals('dropped'));
      });

      test('should deserialize from string correctly', () {
        expect(
          TransactionStatus.values.byName('pending'),
          equals(TransactionStatus.pending),
        );
        expect(
          TransactionStatus.values.byName('confirmed'),
          equals(TransactionStatus.confirmed),
        );
        expect(
          TransactionStatus.values.byName('failed'),
          equals(TransactionStatus.failed),
        );
        expect(
          TransactionStatus.values.byName('dropped'),
          equals(TransactionStatus.dropped),
        );
      });
    });
  });
}
