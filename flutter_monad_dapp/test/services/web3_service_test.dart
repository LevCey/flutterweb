import 'package:flutter_test/flutter_test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_monad_dapp/services/web3_service.dart';

void main() {
  group('Web3Service', () {
    late Web3Service web3Service;
    late EthereumAddress testAddress;
    late EthereumAddress testToAddress;

    setUp(() {
      web3Service = Web3Service();
      testAddress = EthereumAddress.fromHex(
        '0x1234567890123456789012345678901234567890',
      );
      testToAddress = EthereumAddress.fromHex(
        '0x0987654321098765432109876543210987654321',
      );
    });

    tearDown(() {
      web3Service.dispose();
    });

    group('getBalance', () {
      test('should handle balance retrieval errors gracefully', () async {
        // Act & Assert
        expect(
          () => web3Service.getBalance(testAddress),
          throwsA(isA<Web3Exception>()),
        );
      });
    });

    group('sendTransaction', () {
      test('should handle transaction sending errors gracefully', () async {
        // Arrange
        final credentials = EthPrivateKey.fromHex(
          '0x1234567890123456789012345678901234567890123456789012345678901234',
        );
        final value = EtherAmount.fromBigInt(EtherUnit.ether, BigInt.one);

        // Act & Assert
        expect(
          () => web3Service.sendTransaction(
            from: testAddress,
            to: testToAddress,
            value: value,
            credentials: credentials,
          ),
          throwsA(isA<Web3Exception>()),
        );
      });
    });

    group('getTransactionHistory', () {
      test('should return empty list for transaction history', () async {
        // Act
        final result = await web3Service.getTransactionHistory(
          testAddress,
          limit: 5,
        );

        // Assert
        expect(result, isA<List>());
        expect(result, isEmpty);
      });
    });

    group('getTransactionByHash', () {
      test('should handle transaction retrieval errors gracefully', () async {
        // Arrange
        const validHash = '0x1234567890abcdef';

        // Act & Assert
        expect(
          () => web3Service.getTransactionByHash(validHash),
          throwsA(isA<Web3Exception>()),
        );
      });
    });

    group('estimateGas', () {
      test('should handle gas estimation errors gracefully', () async {
        // Arrange
        final value = EtherAmount.fromBigInt(EtherUnit.ether, BigInt.one);

        // Act & Assert
        expect(
          () => web3Service.estimateGas(
            from: testAddress,
            to: testToAddress,
            value: value,
          ),
          throwsA(isA<Web3Exception>()),
        );
      });
    });

    group('getGasPrice', () {
      test('should handle gas price retrieval errors gracefully', () async {
        // Act & Assert
        expect(() => web3Service.getGasPrice(), throwsA(isA<Web3Exception>()));
      });
    });

    group('Web3Exception', () {
      test('should create exception with message', () {
        // Arrange
        const message = 'Test error message';

        // Act
        final exception = Web3Exception(message);

        // Assert
        expect(exception.message, equals(message));
        expect(exception.toString(), equals('Web3Exception: $message'));
      });
    });
  });
}
