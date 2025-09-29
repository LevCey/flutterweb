import 'package:flutter_test/flutter_test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_monad_dapp/models/transfer_state.dart';

void main() {
  group('TransferState', () {
    late EthereumAddress testRecipient;
    late EtherAmount testAmount;
    late EtherAmount testBalance;

    setUp(() {
      testRecipient = EthereumAddress.fromHex(
        '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
      );
      testAmount = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(1000000000000000000),
      ); // 1 ETH
      testBalance = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(5000000000000000000),
      ); // 5 ETH
    });

    group('Factory constructors', () {
      test('should create initial state', () {
        const state = TransferState.initial();
        expect(state, isA<TransferState>());
        expect(state.toString(), contains('initial'));
      });

      test('should create loading state with recipient and amount', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state, isA<TransferState>());
        expect(state.toString(), contains('loading'));
      });

      test('should create success state with transaction hash', () {
        const transactionHash = '0x1234567890abcdef';
        final state = TransferState.success(
          transactionHash: transactionHash,
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state, isA<TransferState>());
        expect(state.toString(), contains('success'));
        expect(state.toString(), contains(transactionHash));
      });

      test('should create error state with message', () {
        const errorMessage = 'Transfer failed';
        const state = TransferState.error(message: errorMessage);
        expect(state, isA<TransferState>());
        expect(state.toString(), contains('error'));
        expect(state.toString(), contains(errorMessage));
      });

      test('should create error state with message and transfer data', () {
        const errorMessage = 'Insufficient balance';
        final state = TransferState.error(
          message: errorMessage,
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state, isA<TransferState>());
        expect(state.toString(), contains('error'));
        expect(state.toString(), contains(errorMessage));
      });
    });

    group('Pattern matching with when', () {
      test('should match initial state', () {
        const state = TransferState.initial();
        final result = state.when(
          initial: () => 'initial',
          loading: (recipient, amount) => 'loading',
          success: (hash, recipient, amount) => 'success',
          error: (message, recipient, amount) => 'error',
        );
        expect(result, equals('initial'));
      });

      test('should match loading state with data', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        final result = state.when(
          initial: () => 'initial',
          loading: (recipient, amount) =>
              'loading-${recipient.hex}-${amount.getInWei}',
          success: (hash, recipient, amount) => 'success',
          error: (message, recipient, amount) => 'error',
        );
        expect(
          result,
          equals('loading-${testRecipient.hex}-${testAmount.getInWei}'),
        );
      });

      test('should match success state with transaction hash', () {
        const transactionHash = '0x1234567890abcdef';
        final state = TransferState.success(
          transactionHash: transactionHash,
          recipient: testRecipient,
          amount: testAmount,
        );
        final result = state.when(
          initial: () => 'initial',
          loading: (recipient, amount) => 'loading',
          success: (hash, recipient, amount) => 'success-$hash',
          error: (message, recipient, amount) => 'error',
        );
        expect(result, equals('success-$transactionHash'));
      });

      test('should match error state with message', () {
        const errorMessage = 'Test error';
        const state = TransferState.error(message: errorMessage);
        final result = state.when(
          initial: () => 'initial',
          loading: (recipient, amount) => 'loading',
          success: (hash, recipient, amount) => 'success',
          error: (message, recipient, amount) => 'error-$message',
        );
        expect(result, equals('error-$errorMessage'));
      });
    });

    group('Pattern matching with maybeWhen', () {
      test('should match specific state and ignore others', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        final result = state.maybeWhen(
          loading: (recipient, amount) => 'found loading',
          orElse: () => 'other state',
        );
        expect(result, equals('found loading'));
      });

      test('should use orElse for unmatched states', () {
        const state = TransferState.initial();
        final result = state.maybeWhen(
          loading: (recipient, amount) => 'found loading',
          orElse: () => 'other state',
        );
        expect(result, equals('other state'));
      });
    });

    group('Equality and hashCode', () {
      test('should be equal for same initial states', () {
        const state1 = TransferState.initial();
        const state2 = TransferState.initial();
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should be equal for same loading states', () {
        final state1 = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        final state2 = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should be equal for same success states', () {
        const transactionHash = '0x1234567890abcdef';
        final state1 = TransferState.success(
          transactionHash: transactionHash,
          recipient: testRecipient,
          amount: testAmount,
        );
        final state2 = TransferState.success(
          transactionHash: transactionHash,
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should be equal for same error states', () {
        const message = 'Same error';
        const state1 = TransferState.error(message: message);
        const state2 = TransferState.error(message: message);
        expect(state1, equals(state2));
        expect(state1.hashCode, equals(state2.hashCode));
      });

      test('should not be equal for different states', () {
        const state1 = TransferState.initial();
        final state2 = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state1, isNot(equals(state2)));
      });

      test('should not be equal for different loading states', () {
        final state1 = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        final differentRecipient = EthereumAddress.fromHex(
          '0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359',
        );
        final state2 = TransferState.loading(
          recipient: differentRecipient,
          amount: testAmount,
        );
        expect(state1, isNot(equals(state2)));
      });
    });

    group('JSON serialization', () {
      test('should serialize and deserialize initial state', () {
        const originalState = TransferState.initial();
        final json = originalState.toJson();
        final deserializedState = TransferState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test('should serialize and deserialize loading state', () {
        final originalState = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        final json = originalState.toJson();
        final deserializedState = TransferState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test('should serialize and deserialize success state', () {
        const transactionHash = '0x1234567890abcdef';
        final originalState = TransferState.success(
          transactionHash: transactionHash,
          recipient: testRecipient,
          amount: testAmount,
        );
        final json = originalState.toJson();
        final deserializedState = TransferState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test('should serialize and deserialize error state', () {
        const originalState = TransferState.error(
          message: 'Test error message',
        );
        final json = originalState.toJson();
        final deserializedState = TransferState.fromJson(json);
        expect(deserializedState, equals(originalState));
      });

      test(
        'should serialize and deserialize error state with transfer data',
        () {
          final originalState = TransferState.error(
            message: 'Test error message',
            recipient: testRecipient,
            amount: testAmount,
          );
          final json = originalState.toJson();
          final deserializedState = TransferState.fromJson(json);
          expect(deserializedState, equals(originalState));
        },
      );
    });
  });

  group('TransferStateExtensions', () {
    late EthereumAddress testRecipient;
    late EthereumAddress zeroAddress;
    late EtherAmount testAmount;
    late EtherAmount zeroAmount;

    setUp(() {
      testRecipient = EthereumAddress.fromHex(
        '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed',
      );
      zeroAddress = EthereumAddress.fromHex(
        '0x0000000000000000000000000000000000000000',
      );
      testAmount = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(1000000000000000000),
      ); // 1 ETH
      zeroAmount = EtherAmount.fromBigInt(EtherUnit.wei, BigInt.zero); // 0 ETH
    });

    group('hasValidTransferData', () {
      test('should return false for initial state', () {
        const state = TransferState.initial();
        expect(state.hasValidTransferData, isFalse);
      });

      test('should return true for loading state with valid data', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.hasValidTransferData, isTrue);
      });

      test('should return false for loading state with zero address', () {
        final state = TransferState.loading(
          recipient: zeroAddress,
          amount: testAmount,
        );
        expect(state.hasValidTransferData, isFalse);
      });

      test('should return false for loading state with zero amount', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: zeroAmount,
        );
        expect(state.hasValidTransferData, isFalse);
      });

      test('should return true for success state with valid data', () {
        final state = TransferState.success(
          transactionHash: '0x123',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.hasValidTransferData, isTrue);
      });

      test('should return false for error state without transfer data', () {
        const state = TransferState.error(message: 'Error');
        expect(state.hasValidTransferData, isFalse);
      });

      test('should return true for error state with valid transfer data', () {
        final state = TransferState.error(
          message: 'Error',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.hasValidTransferData, isTrue);
      });
    });

    group('recipient getter', () {
      test('should return null for initial state', () {
        const state = TransferState.initial();
        expect(state.recipient, isNull);
      });

      test('should return recipient for loading state', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.recipient, equals(testRecipient));
      });

      test('should return recipient for success state', () {
        final state = TransferState.success(
          transactionHash: '0x123',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.recipient, equals(testRecipient));
      });

      test('should return null for error state without recipient', () {
        const state = TransferState.error(message: 'Error');
        expect(state.recipient, isNull);
      });

      test('should return recipient for error state with recipient', () {
        final state = TransferState.error(
          message: 'Error',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.recipient, equals(testRecipient));
      });
    });

    group('amount getter', () {
      test('should return null for initial state', () {
        const state = TransferState.initial();
        expect(state.amount, isNull);
      });

      test('should return amount for loading state', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.amount, equals(testAmount));
      });

      test('should return amount for success state', () {
        final state = TransferState.success(
          transactionHash: '0x123',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.amount, equals(testAmount));
      });

      test('should return null for error state without amount', () {
        const state = TransferState.error(message: 'Error');
        expect(state.amount, isNull);
      });

      test('should return amount for error state with amount', () {
        final state = TransferState.error(
          message: 'Error',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.amount, equals(testAmount));
      });
    });

    group('isTransferInProgress', () {
      test('should return false for initial state', () {
        const state = TransferState.initial();
        expect(state.isTransferInProgress, isFalse);
      });

      test('should return true for loading state', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.isTransferInProgress, isTrue);
      });

      test('should return false for success state', () {
        final state = TransferState.success(
          transactionHash: '0x123',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.isTransferInProgress, isFalse);
      });

      test('should return false for error state', () {
        const state = TransferState.error(message: 'Error');
        expect(state.isTransferInProgress, isFalse);
      });
    });

    group('transactionHash getter', () {
      test('should return null for initial state', () {
        const state = TransferState.initial();
        expect(state.transactionHash, isNull);
      });

      test('should return null for loading state', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.transactionHash, isNull);
      });

      test('should return transaction hash for success state', () {
        const hash = '0x1234567890abcdef';
        final state = TransferState.success(
          transactionHash: hash,
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.transactionHash, equals(hash));
      });

      test('should return null for error state', () {
        const state = TransferState.error(message: 'Error');
        expect(state.transactionHash, isNull);
      });
    });

    group('errorMessage getter', () {
      test('should return null for initial state', () {
        const state = TransferState.initial();
        expect(state.errorMessage, isNull);
      });

      test('should return null for loading state', () {
        final state = TransferState.loading(
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.errorMessage, isNull);
      });

      test('should return null for success state', () {
        final state = TransferState.success(
          transactionHash: '0x123',
          recipient: testRecipient,
          amount: testAmount,
        );
        expect(state.errorMessage, isNull);
      });

      test('should return error message for error state', () {
        const message = 'Transfer failed';
        const state = TransferState.error(message: message);
        expect(state.errorMessage, equals(message));
      });
    });
  });

  group('TransferValidation', () {
    group('isValidAddress', () {
      test('should return true for valid Ethereum address', () {
        const validAddress = '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed';
        expect(TransferValidation.isValidAddress(validAddress), isTrue);
      });

      test('should return false for zero address', () {
        const zeroAddress = '0x0000000000000000000000000000000000000000';
        expect(TransferValidation.isValidAddress(zeroAddress), isFalse);
      });

      test('should return false for invalid address format', () {
        const invalidAddress = '0xinvalid';
        expect(TransferValidation.isValidAddress(invalidAddress), isFalse);
      });

      test('should return false for empty string', () {
        expect(TransferValidation.isValidAddress(''), isFalse);
      });

      test('should return false for non-hex string', () {
        const nonHexAddress = 'not-an-address';
        expect(TransferValidation.isValidAddress(nonHexAddress), isFalse);
      });
    });

    group('isValidAmount', () {
      test('should return true for positive amount', () {
        expect(TransferValidation.isValidAmount('1.0'), isTrue);
        expect(TransferValidation.isValidAmount('0.5'), isTrue);
        expect(TransferValidation.isValidAmount('100'), isTrue);
      });

      test('should return false for zero amount', () {
        expect(TransferValidation.isValidAmount('0'), isFalse);
        expect(TransferValidation.isValidAmount('0.0'), isFalse);
      });

      test('should return false for negative amount', () {
        expect(TransferValidation.isValidAmount('-1.0'), isFalse);
        expect(TransferValidation.isValidAmount('-0.5'), isFalse);
      });

      test('should return false for invalid number format', () {
        expect(TransferValidation.isValidAmount('invalid'), isFalse);
        expect(TransferValidation.isValidAmount(''), isFalse);
        expect(TransferValidation.isValidAmount('1.0.0'), isFalse);
      });
    });

    group('isAmountWithinBalance', () {
      late EtherAmount testBalance;

      setUp(() {
        testBalance = EtherAmount.fromBigInt(
          EtherUnit.wei,
          BigInt.from(5000000000000000000),
        ); // 5 ETH
      });

      test('should return true for amount within balance', () {
        expect(
          TransferValidation.isAmountWithinBalance('1.0', testBalance),
          isTrue,
        );
        expect(
          TransferValidation.isAmountWithinBalance('5.0', testBalance),
          isTrue,
        );
        expect(
          TransferValidation.isAmountWithinBalance('4.99', testBalance),
          isTrue,
        );
      });

      test('should return false for amount exceeding balance', () {
        expect(
          TransferValidation.isAmountWithinBalance('5.1', testBalance),
          isFalse,
        );
        expect(
          TransferValidation.isAmountWithinBalance('10.0', testBalance),
          isFalse,
        );
      });

      test('should return false for invalid amount format', () {
        expect(
          TransferValidation.isAmountWithinBalance('invalid', testBalance),
          isFalse,
        );
      });
    });

    group('createEtherAmount', () {
      test('should create EtherAmount for valid amount string', () {
        final amount = TransferValidation.createEtherAmount('1.0');
        expect(amount, isNotNull);
        expect(amount!.getValueInUnit(EtherUnit.ether), equals(1.0));
      });

      test('should create EtherAmount for decimal amount', () {
        final amount = TransferValidation.createEtherAmount('0.5');
        expect(amount, isNotNull);
        expect(amount!.getValueInUnit(EtherUnit.ether), equals(0.5));
      });

      test('should return null for invalid amount string', () {
        final amount = TransferValidation.createEtherAmount('invalid');
        expect(amount, isNull);
      });

      test('should return null for empty string', () {
        final amount = TransferValidation.createEtherAmount('');
        expect(amount, isNull);
      });
    });

    group('createEthereumAddress', () {
      test('should create EthereumAddress for valid address string', () {
        const validAddress = '0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed';
        final address = TransferValidation.createEthereumAddress(validAddress);
        expect(address, isNotNull);
        expect(address!.hex.toLowerCase(), equals(validAddress.toLowerCase()));
      });

      test('should return null for invalid address string', () {
        const invalidAddress = '0xinvalid';
        final address = TransferValidation.createEthereumAddress(
          invalidAddress,
        );
        expect(address, isNull);
      });

      test('should return null for empty string', () {
        final address = TransferValidation.createEthereumAddress('');
        expect(address, isNull);
      });
    });
  });
}
