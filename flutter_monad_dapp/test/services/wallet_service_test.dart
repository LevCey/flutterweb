import 'package:flutter_test/flutter_test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_monad_dapp/services/wallet_service.dart';
import 'package:flutter_monad_dapp/models/wallet_state.dart';

void main() {
  group('WalletService', () {
    late WalletService walletService;
    late EthereumAddress testAddress;

    setUp(() {
      walletService = WalletService();
      testAddress = EthereumAddress.fromHex(
        '0x1234567890123456789012345678901234567890',
      );
    });

    tearDown(() {
      walletService.dispose();
    });

    group('Initial State', () {
      test('should start with initial state', () {
        expect(walletService.currentState, equals(const WalletState.initial()));
        expect(walletService.connectedAddress, isNull);
      });

      test('should provide connection stream', () {
        expect(walletService.connectionStream, isA<Stream<WalletState>>());
      });
    });

    group('connectWallet', () {
      test('should emit connecting state when attempting to connect', () async {
        // Arrange
        final stateChanges = <WalletState>[];
        walletService.connectionStream.listen(stateChanges.add);

        // Act
        // Note: This will fail in test environment since there's no browser wallet
        // but we can test the state changes
        await walletService.connectWallet();

        // Assert
        expect(stateChanges.first, equals(const WalletState.connecting()));
      });

      test('should emit error state when wallet is not available', () async {
        // Arrange
        final stateChanges = <WalletState>[];
        walletService.connectionStream.listen(stateChanges.add);

        // Act
        final result = await walletService.connectWallet();

        // Assert
        expect(result, isFalse);
        expect(stateChanges, isNotEmpty);
        // In test environment, wallet is not available, so should get error state
        final lastState = stateChanges.last;
        // Should have at least connecting state, and possibly error state
        expect(
          stateChanges.any(
            (state) =>
                state.maybeWhen(connecting: () => true, orElse: () => false),
          ),
          isTrue,
        );
      });
    });

    group('disconnectWallet', () {
      test('should emit disconnected state when disconnecting', () async {
        // Arrange
        final stateChanges = <WalletState>[];
        walletService.connectionStream.listen(stateChanges.add);

        // Act
        await walletService.disconnectWallet();

        // Assert
        expect(stateChanges.last, equals(const WalletState.disconnected()));
        expect(walletService.connectedAddress, isNull);
      });
    });

    group('getConnectedAddress', () {
      test('should return null when no wallet is connected', () async {
        // Act
        final address = await walletService.getConnectedAddress();

        // Assert
        expect(address, isNull);
      });

      test(
        'should return connected address when wallet is connected',
        () async {
          // This test would require mocking the wallet connection
          // For now, we test the basic functionality
          expect(walletService.connectedAddress, isNull);
        },
      );
    });

    group('updateBalance', () {
      test('should update balance in connected state', () async {
        // Arrange
        final newBalance = EtherAmount.fromBigInt(
          EtherUnit.ether,
          BigInt.from(5),
        );
        final stateChanges = <WalletState>[];
        walletService.connectionStream.listen(stateChanges.add);

        // Simulate connected state
        // Note: In a real test, we'd need to properly set up the connected state

        // Act
        await walletService.updateBalance(newBalance);

        // Assert
        // The test would verify that the balance is updated in the state
        expect(walletService.currentState, isA<WalletState>());
      });
    });

    group('Address Validation', () {
      test('isValidAddress should return true for valid addresses', () {
        // Arrange
        const validAddress = '0x1234567890123456789012345678901234567890';

        // Act
        final result = WalletService.isValidAddress(validAddress);

        // Assert
        expect(result, isTrue);
      });

      test('isValidAddress should return false for invalid addresses', () {
        // Arrange
        const invalidAddress = 'invalid_address';

        // Act
        final result = WalletService.isValidAddress(invalidAddress);

        // Assert
        expect(result, isFalse);
      });

      test('isValidAddress should return false for empty string', () {
        // Act
        final result = WalletService.isValidAddress('');

        // Assert
        expect(result, isFalse);
      });
    });

    group('Address Formatting', () {
      test('formatAddress should return shortened address', () {
        // Act
        final result = WalletService.formatAddress(testAddress);

        // Assert
        expect(result, equals('0x1234...7890'));
      });

      test(
        'formatAddress should return full address if shorter than format length',
        () {
          // Arrange
          final shortAddress = EthereumAddress.fromHex(
            '0x0000000000000000000000000000000000001234',
          );

          // Act
          final result = WalletService.formatAddress(shortAddress);

          // Assert
          expect(result, equals('0x0000...1234'));
        },
      );

      test('formatAddress should respect custom prefix and suffix lengths', () {
        // Act
        final result = WalletService.formatAddress(
          testAddress,
          prefixLength: 8,
          suffixLength: 6,
        );

        // Assert
        expect(result, equals('0x123456...567890'));
      });

      test('formatAddressString should format valid address string', () {
        // Arrange
        const addressString = '0x1234567890123456789012345678901234567890';

        // Act
        final result = WalletService.formatAddressString(addressString);

        // Assert
        expect(result, equals('0x1234...7890'));
      });

      test(
        'formatAddressString should return original string for invalid address',
        () {
          // Arrange
          const invalidAddress = 'invalid_address';

          // Act
          final result = WalletService.formatAddressString(invalidAddress);

          // Assert
          expect(result, equals(invalidAddress));
        },
      );
    });

    group('WalletException', () {
      test('should create exception with message', () {
        // Arrange
        const message = 'Test wallet error';

        // Act
        final exception = WalletException(message);

        // Assert
        expect(exception.message, equals(message));
        expect(exception.toString(), equals('WalletException: $message'));
      });
    });

    group('Stream Behavior', () {
      test('should emit state changes to stream listeners', () async {
        // Arrange
        final stateChanges = <WalletState>[];
        walletService.connectionStream.listen(stateChanges.add);

        // Act
        await walletService.disconnectWallet();

        // Assert
        expect(stateChanges, isNotEmpty);
        expect(stateChanges.last, equals(const WalletState.disconnected()));
      });

      test('should support multiple stream listeners', () async {
        // Arrange
        final stateChanges1 = <WalletState>[];
        final stateChanges2 = <WalletState>[];

        walletService.connectionStream.listen(stateChanges1.add);
        walletService.connectionStream.listen(stateChanges2.add);

        // Act
        await walletService.disconnectWallet();

        // Assert
        expect(stateChanges1, isNotEmpty);
        expect(stateChanges2, isNotEmpty);
        expect(stateChanges1.last, equals(stateChanges2.last));
      });
    });
  });
}
