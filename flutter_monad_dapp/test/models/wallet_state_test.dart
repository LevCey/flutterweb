import 'package:flutter_test/flutter_test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_monad_dapp/models/wallet_state.dart';
import 'package:flutter_monad_dapp/models/wallet_state_extensions.dart';

void main() {
  group('WalletState', () {
    late EthereumAddress testAddress;
    late EtherAmount testBalance;

    setUp(() {
      testAddress = EthereumAddress.fromHex(
        '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
      );
      testBalance = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(1000000000000000000),
      ); // 1 ETH
    });

    group('Factory constructors', () {
      test('should create initial state', () {
        const state = WalletState.initial();
        expect(state, isA<WalletState>());
        expect(state.toString(), contains('initial'));
      });

      test('should create connecting state', () {
        const state = WalletState.connecting();
        expect(state, isA<WalletState>());
        expect(state.toString(), contains('connecting'));
      });

      test('should create connected state with address and balance', () {
        final state = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        expect(state, isA<WalletState>());
        expect(state.toString(), contains('connected'));
      });

      test('should create disconnected state', () {
        const state = WalletState.disconnected();
        expect(state, isA<WalletState>());
        expect(state.toString(), contains('disconnected'));
      });

      test('should create error state with message', () {
        const errorMessage = 'Connection failed';
        const state = WalletState.error(errorMessage);
        expect(state, isA<WalletState>());
        expect(state.toString(), contains('error'));
        expect(state.toString(), contains(errorMessage));
      });
    });

    group('Pattern matching with when', () {
      test('should match initial state', () {
        const state = WalletState.initial();
        final result = state.when(
          initial: () => 'initial',
          connecting: () => 'connecting',
          connected: (address, balance) => 'connected',
          disconnected: () => 'disconnected',
          error: (message) => 'error',
        );
        expect(result, equals('initial'));
      });

      test('should match connecting state', () {
        const state = WalletState.connecting();
        final result = state.when(
          initial: () => 'initial',
          connecting: () => 'connecting',
          connected: (address, balance) => 'connected',
          disconnected: () => 'disconnected',
          error: (message) => 'error',
        );
        expect(result, equals('connecting'));
      });

      test('should match connected state with data', () {
        final state = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        final result = state.when(
          initial: () => 'initial',
          connecting: () => 'connecting',
          connected: (address, balance) =>
              'connected-${address.hex}-${balance.getInWei}',
          disconnected: () => 'disconnected',
          error: (message) => 'error',
        );
        expect(
          result,
          equals('connected-${testAddress.hex}-${testBalance.getInWei}'),
        );
      });

      test('should match disconnected state', () {
        const state = WalletState.disconnected();
        final result = state.when(
          initial: () => 'initial',
          connecting: () => 'connecting',
          connected: (address, balance) => 'connected',
          disconnected: () => 'disconnected',
          error: (message) => 'error',
        );
        expect(result, equals('disconnected'));
      });

      test('should match error state with message', () {
        const errorMessage = 'Test error';
        const state = WalletState.error(errorMessage);
        final result = state.when(
          initial: () => 'initial',
          connecting: () => 'connecting',
          connected: (address, balance) => 'connected',
          disconnected: () => 'disconnected',
          error: (message) => 'error-$message',
        );
        expect(result, equals('error-$errorMessage'));
      });
    });

    group('Pattern matching with maybeWhen', () {
      test('should match specific state and ignore others', () {
        const state = WalletState.connecting();
        final result = state.maybeWhen(
          connecting: () => 'found connecting',
          orElse: () => 'other state',
        );
        expect(result, equals('found connecting'));
      });

      test('should use orElse for unmatched states', () {
        const state = WalletState.initial();
        final result = state.maybeWhen(
          connecting: () => 'found connecting',
          orElse: () => 'other state',
        );
        expect(result, equals('other state'));
      });
    });

    group('CopyWith functionality', () {
      test('should copy connected state with new address', () {
        final originalState = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        final newAddress = EthereumAddress.fromHex(
          '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
        );
        final copiedState = originalState.when(
          initial: () => originalState,
          connecting: () => originalState,
          connected: (address, balance) =>
              WalletState.connected(address: newAddress, balance: balance),
          disconnected: () => originalState,
          error: (message) => originalState,
        );

        expect(copiedState, isA<WalletState>());
        copiedState.when(
          initial: () => fail('Should be connected'),
          connecting: () => fail('Should be connected'),
          connected: (address, balance) {
            expect(address, equals(newAddress));
            expect(balance, equals(testBalance));
          },
          disconnected: () => fail('Should be connected'),
          error: (message) => fail('Should be connected'),
        );
      });

      test('should copy connected state with new balance', () {
        final originalState = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        final newBalance = EtherAmount.fromBigInt(
          EtherUnit.wei,
          BigInt.from(2000000000000000000),
        ); // 2 ETH
        final copiedState = originalState.when(
          initial: () => originalState,
          connecting: () => originalState,
          connected: (address, balance) =>
              WalletState.connected(address: address, balance: newBalance),
          disconnected: () => originalState,
          error: (message) => originalState,
        );

        copiedState.when(
          initial: () => fail('Should be connected'),
          connecting: () => fail('Should be connected'),
          connected: (address, balance) {
            expect(address, equals(testAddress));
            expect(balance, equals(newBalance));
          },
          disconnected: () => fail('Should be connected'),
          error: (message) => fail('Should be connected'),
        );
      });

      test('should copy error state with new message', () {
        const originalState = WalletState.error('Original error');
        const newMessage = 'New error message';
        const copiedState = WalletState.error(newMessage);

        copiedState.when(
          initial: () => fail('Should be error'),
          connecting: () => fail('Should be error'),
          connected: (address, balance) => fail('Should be error'),
          disconnected: () => fail('Should be error'),
          error: (message) => expect(message, equals(newMessage)),
        );
      });
    });

    group('Equality and hashCode', () {
      test('should be equal for same initial states', () {
        const state1 = WalletState.initial();
        const state2 = WalletState.initial();
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should be equal for same connecting states', () {
        const state1 = WalletState.connecting();
        const state2 = WalletState.connecting();
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should be equal for same connected states', () {
        final state1 = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        final state2 = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should be equal for same disconnected states', () {
        const state1 = WalletState.disconnected();
        const state2 = WalletState.disconnected();
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should be equal for same error states', () {
        const message = 'Same error';
        const state1 = WalletState.error(message);
        const state2 = WalletState.error(message);
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should not be equal for different states', () {
        const state1 = WalletState.initial();
        const state2 = WalletState.connecting();
        expect(state1, isNot(equals(state2)));
      });

      test('should not be equal for different connected states', () {
        final state1 = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        final differentAddress = EthereumAddress.fromHex(
          '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
        );
        final state2 = WalletState.connected(
          address: differentAddress,
          balance: testBalance,
        );
        expect(state1, isNot(equals(state2)));
      });
    });

    group('JSON serialization', () {
      test('should serialize and deserialize initial state', () {
        const originalState = WalletState.initial();
        final json = originalState.toJson();
        final deserializedState = WalletState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test('should serialize and deserialize connecting state', () {
        const originalState = WalletState.connecting();
        final json = originalState.toJson();
        final deserializedState = WalletState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test('should serialize and deserialize connected state', () {
        final originalState = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );
        final json = originalState.toJson();
        final deserializedState = WalletState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test('should serialize and deserialize disconnected state', () {
        const originalState = WalletState.disconnected();
        final json = originalState.toJson();
        final deserializedState = WalletState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test('should serialize and deserialize error state', () {
        const originalState = WalletState.error('Test error message');
        final json = originalState.toJson();
        final deserializedState = WalletState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });
    });
  });

  group('WalletStateX Extensions', () {
    late EthereumAddress testAddress;
    late EtherAmount testBalance;

    setUp(() {
      testAddress = EthereumAddress.fromHex(
        '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
      );
      testBalance = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(1000000000000000000),
      ); // 1 ETH
    });

    group('State checking extensions', () {
      test('isConnected should return true only for connected state', () {
        expect(const WalletState.initial().isConnected, isFalse);
        expect(const WalletState.connecting().isConnected, isFalse);
        expect(
          WalletState.connected(
            address: testAddress,
            balance: testBalance,
          ).isConnected,
          isTrue,
        );
        expect(const WalletState.disconnected().isConnected, isFalse);
        expect(const WalletState.error('error').isConnected, isFalse);
      });

      test('isConnecting should return true only for connecting state', () {
        expect(const WalletState.initial().isConnecting, isFalse);
        expect(const WalletState.connecting().isConnecting, isTrue);
        expect(
          WalletState.connected(
            address: testAddress,
            balance: testBalance,
          ).isConnecting,
          isFalse,
        );
        expect(const WalletState.disconnected().isConnecting, isFalse);
        expect(const WalletState.error('error').isConnecting, isFalse);
      });

      test('hasError should return true only for error state', () {
        expect(const WalletState.initial().hasError, isFalse);
        expect(const WalletState.connecting().hasError, isFalse);
        expect(
          WalletState.connected(
            address: testAddress,
            balance: testBalance,
          ).hasError,
          isFalse,
        );
        expect(const WalletState.disconnected().hasError, isFalse);
        expect(const WalletState.error('error').hasError, isTrue);
      });
    });

    group('Data extraction extensions', () {
      test(
        'connectedAddress should return address only for connected state',
        () {
          expect(const WalletState.initial().connectedAddress, isNull);
          expect(const WalletState.connecting().connectedAddress, isNull);
          expect(
            WalletState.connected(
              address: testAddress,
              balance: testBalance,
            ).connectedAddress,
            equals(testAddress),
          );
          expect(const WalletState.disconnected().connectedAddress, isNull);
          expect(const WalletState.error('error').connectedAddress, isNull);
        },
      );

      test('currentBalance should return balance only for connected state', () {
        expect(const WalletState.initial().currentBalance, isNull);
        expect(const WalletState.connecting().currentBalance, isNull);
        expect(
          WalletState.connected(
            address: testAddress,
            balance: testBalance,
          ).currentBalance,
          equals(testBalance),
        );
        expect(const WalletState.disconnected().currentBalance, isNull);
        expect(const WalletState.error('error').currentBalance, isNull);
      });

      test('errorMessage should return message only for error state', () {
        const errorMessage = 'Test error message';
        expect(const WalletState.initial().errorMessage, isNull);
        expect(const WalletState.connecting().errorMessage, isNull);
        expect(
          WalletState.connected(
            address: testAddress,
            balance: testBalance,
          ).errorMessage,
          isNull,
        );
        expect(const WalletState.disconnected().errorMessage, isNull);
        expect(
          const WalletState.error(errorMessage).errorMessage,
          equals(errorMessage),
        );
      });
    });

    group('Formatting extensions', () {
      test(
        'formattedAddress should return shortened address for connected state',
        () {
          final connectedState = WalletState.connected(
            address: testAddress,
            balance: testBalance,
          );
          final formatted = connectedState.formattedAddress;
          expect(formatted, isNotNull);
          expect(formatted, startsWith('0x5aae'));
          expect(formatted, endsWith('eaed'));
          expect(formatted, contains('...'));
        },
      );

      test('formattedAddress should return null for non-connected states', () {
        expect(const WalletState.initial().formattedAddress, isNull);
        expect(const WalletState.connecting().formattedAddress, isNull);
        expect(const WalletState.disconnected().formattedAddress, isNull);
        expect(const WalletState.error('error').formattedAddress, isNull);
      });

      test(
        'formattedBalance should return ETH formatted balance for connected state',
        () {
          final connectedState = WalletState.connected(
            address: testAddress,
            balance: testBalance,
          );
          final formatted = connectedState.formattedBalance;
          expect(formatted, isNotNull);
          expect(formatted, equals('1.0000 ETH'));
        },
      );

      test('formattedBalance should return null for non-connected states', () {
        expect(const WalletState.initial().formattedBalance, isNull);
        expect(const WalletState.connecting().formattedBalance, isNull);
        expect(const WalletState.disconnected().formattedBalance, isNull);
        expect(const WalletState.error('error').formattedBalance, isNull);
      });

      test('formattedBalance should handle different amounts correctly', () {
        final smallBalance = EtherAmount.fromBigInt(
          EtherUnit.wei,
          BigInt.from(500000000000000000),
        ); // 0.5 ETH
        final largeBalance = EtherAmount.fromBigInt(
          EtherUnit.wei,
          BigInt.from(2500000000000000000),
        ); // 2.5 ETH

        final smallBalanceState = WalletState.connected(
          address: testAddress,
          balance: smallBalance,
        );
        final largeBalanceState = WalletState.connected(
          address: testAddress,
          balance: largeBalance,
        );

        expect(smallBalanceState.formattedBalance, equals('0.5000 ETH'));
        expect(largeBalanceState.formattedBalance, equals('2.5000 ETH'));
      });
    });
  });
}
