import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_monad_dapp/models/transfer_state.dart';
import 'package:flutter_monad_dapp/models/wallet_state.dart';
import 'package:flutter_monad_dapp/services/wallet_service.dart';
import 'package:flutter_monad_dapp/services/web3_service.dart';
import 'package:flutter_monad_dapp/viewmodels/transfer_viewmodel.dart';
import 'package:flutter_monad_dapp/viewmodels/wallet_viewmodel.dart';

import 'wallet_viewmodel_test.mocks.dart';

@GenerateMocks([WalletService, Web3Service])
void main() {
  group('TransferViewModel', () {
    late ProviderContainer container;
    late MockWalletService mockWalletService;
    late MockWeb3Service mockWeb3Service;
    late EthereumAddress testFromAddress;
    late EthereumAddress testToAddress;
    late EtherAmount testBalance;
    late EtherAmount testTransferAmount;

    setUp(() {
      mockWalletService = MockWalletService();
      mockWeb3Service = MockWeb3Service();
      testFromAddress = EthereumAddress.fromHex(
        '0x1234567890123456789012345678901234567890',
      );
      testToAddress = EthereumAddress.fromHex(
        '0x0987654321098765432109876543210987654321',
      );
      testBalance = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(2000000000000000000),
      ); // 2 ETH
      testTransferAmount = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(1000000000000000000),
      ); // 1 ETH

      container = ProviderContainer(
        overrides: [
          walletServiceProvider.overrideWithValue(mockWalletService),
          web3ServiceProvider.overrideWithValue(mockWeb3Service),
        ],
      );

      // Set up wallet state manually
      final walletViewModel = container.read(walletViewModelProvider.notifier);
      walletViewModel.state = WalletState.connected(
        address: testFromAddress,
        balance: testBalance,
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state should be TransferState.initial', () {
      final viewModel = container.read(transferViewModelProvider.notifier);
      final state = container.read(transferViewModelProvider);

      expect(state, equals(const TransferState.initial()));
    });

    group('form validation', () {
      test('updateRecipient should update recipient address', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        viewModel.updateRecipient(testToAddress.hex);

        expect(viewModel.recipientAddress, equals(testToAddress.hex));
      });

      test('updateAmount should update amount', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        viewModel.updateAmount('1.0');

        expect(viewModel.amount, equals('1.0'));
      });

      test('validateForm should return errors for empty fields', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        final errors = viewModel.validateForm();

        expect(errors['recipient'], equals('Recipient address is required'));
        expect(errors['amount'], equals('Amount is required'));
      });

      test('validateForm should return error for invalid address', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        viewModel.updateRecipient('invalid_address');
        viewModel.updateAmount('1.0');

        final errors = viewModel.validateForm();

        expect(errors['recipient'], equals('Invalid Ethereum address format'));
      });

      test('validateForm should return error for invalid amount', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        viewModel.updateRecipient(testToAddress.hex);
        viewModel.updateAmount('invalid_amount');

        final errors = viewModel.validateForm();

        expect(errors['amount'], equals('Invalid amount format'));
      });

      test('validateForm should return error for amount exceeding balance', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        viewModel.updateRecipient(testToAddress.hex);
        viewModel.updateAmount('5.0'); // More than 2 ETH balance

        final errors = viewModel.validateForm();

        expect(errors['amount'], equals('Amount exceeds available balance'));
      });

      test('validateForm should return empty map for valid form', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        viewModel.updateRecipient(testToAddress.hex);
        viewModel.updateAmount('1.0');

        final errors = viewModel.validateForm();

        expect(errors, isEmpty);
      });

      test('isFormValid should return true for valid form', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        viewModel.updateRecipient(testToAddress.hex);
        viewModel.updateAmount('1.0');

        expect(viewModel.isFormValid, isTrue);
      });

      test('isFormValid should return false for invalid form', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        expect(viewModel.isFormValid, isFalse);
      });
    });

    group('sendTokens', () {
      test(
        'should update state to loading then success on successful transfer',
        () async {
          // Arrange
          const txHash = '0xabcdef1234567890';
          when(
            mockWeb3Service.sendTransaction(
              from: anyNamed('from'),
              to: anyNamed('to'),
              value: anyNamed('value'),
              credentials: anyNamed('credentials'),
            ),
          ).thenAnswer((_) async => txHash);

          final viewModel = container.read(transferViewModelProvider.notifier);

          // Act
          await viewModel.sendTokens(testToAddress.hex, 1.0);

          // Assert
          final finalState = container.read(transferViewModelProvider);

          finalState.when(
            initial: () => fail('Expected success state'),
            loading: (recipient, amount) => fail('Expected success state'),
            success: (hash, recipient, amount) {
              expect(hash, equals(txHash));
              expect(recipient, equals(testToAddress));
              expect(amount.getValueInUnit(EtherUnit.ether), equals(1.0));
            },
            error: (message, recipient, amount) =>
                fail('Expected success state, got error: $message'),
          );

          verify(
            mockWeb3Service.sendTransaction(
              from: testFromAddress,
              to: testToAddress,
              value: anyNamed('value'),
              credentials: anyNamed('credentials'),
            ),
          ).called(1);
        },
      );

      test(
        'should update state to error for invalid recipient address',
        () async {
          final viewModel = container.read(transferViewModelProvider.notifier);

          // Act
          await viewModel.sendTokens('invalid_address', 1.0);

          // Assert
          final finalState = container.read(transferViewModelProvider);

          finalState.when(
            initial: () => fail('Expected error state'),
            loading: (recipient, amount) => fail('Expected error state'),
            success: (hash, recipient, amount) => fail('Expected error state'),
            error: (message, recipient, amount) {
              expect(message, equals('Invalid recipient address'));
            },
          );
        },
      );

      test('should update state to error for zero amount', () async {
        final viewModel = container.read(transferViewModelProvider.notifier);

        // Act
        await viewModel.sendTokens(testToAddress.hex, 0.0);

        // Assert
        final finalState = container.read(transferViewModelProvider);

        finalState.when(
          initial: () => fail('Expected error state'),
          loading: (recipient, amount) => fail('Expected error state'),
          success: (hash, recipient, amount) => fail('Expected error state'),
          error: (message, recipient, amount) {
            expect(message, equals('Amount must be greater than zero'));
          },
        );
      });

      test('should update state to error for insufficient balance', () async {
        final viewModel = container.read(transferViewModelProvider.notifier);

        // Act - try to send 5 ETH when balance is 2 ETH
        await viewModel.sendTokens(testToAddress.hex, 5.0);

        // Assert
        final finalState = container.read(transferViewModelProvider);

        finalState.when(
          initial: () => fail('Expected error state'),
          loading: (recipient, amount) => fail('Expected error state'),
          success: (hash, recipient, amount) => fail('Expected error state'),
          error: (message, recipient, amount) {
            expect(message, equals('Insufficient balance'));
          },
        );
      });

      test('should update state to error on transaction failure', () async {
        // Arrange
        when(
          mockWeb3Service.sendTransaction(
            from: anyNamed('from'),
            to: anyNamed('to'),
            value: anyNamed('value'),
            credentials: anyNamed('credentials'),
          ),
        ).thenThrow(Exception('Transaction failed'));

        final viewModel = container.read(transferViewModelProvider.notifier);

        // Act
        await viewModel.sendTokens(testToAddress.hex, 1.0);

        // Assert
        final finalState = container.read(transferViewModelProvider);

        finalState.when(
          initial: () => fail('Expected error state'),
          loading: (recipient, amount) => fail('Expected error state'),
          success: (hash, recipient, amount) => fail('Expected error state'),
          error: (message, recipient, amount) {
            expect(message, contains('Transfer failed'));
          },
        );
      });
    });

    group('sendTokensFromForm', () {
      test('should send tokens using form values when form is valid', () async {
        // Arrange
        const txHash = '0xabcdef1234567890';
        when(
          mockWeb3Service.sendTransaction(
            from: anyNamed('from'),
            to: anyNamed('to'),
            value: anyNamed('value'),
            credentials: anyNamed('credentials'),
          ),
        ).thenAnswer((_) async => txHash);

        final viewModel = container.read(transferViewModelProvider.notifier);
        viewModel.updateRecipient(testToAddress.hex);
        viewModel.updateAmount('1.0');

        // Act
        await viewModel.sendTokensFromForm();

        // Assert
        final finalState = container.read(transferViewModelProvider);

        finalState.when(
          initial: () => fail('Expected success state'),
          loading: (recipient, amount) => fail('Expected success state'),
          success: (hash, recipient, amount) {
            expect(hash, equals(txHash));
          },
          error: (message, recipient, amount) =>
              fail('Expected success state, got error: $message'),
        );
      });

      test('should update state to error when form is invalid', () async {
        final viewModel = container.read(transferViewModelProvider.notifier);
        // Don't set form values, so form is invalid

        // Act
        await viewModel.sendTokensFromForm();

        // Assert
        final finalState = container.read(transferViewModelProvider);

        finalState.when(
          initial: () => fail('Expected error state'),
          loading: (recipient, amount) => fail('Expected error state'),
          success: (hash, recipient, amount) => fail('Expected error state'),
          error: (message, recipient, amount) {
            expect(message, equals('Recipient address is required'));
          },
        );
      });
    });

    group('utility methods', () {
      test('resetState should set state to initial', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        // Set state to error first
        viewModel.state = const TransferState.error(message: 'Test error');

        // Act
        viewModel.resetState();

        // Assert
        final finalState = container.read(transferViewModelProvider);
        expect(finalState, equals(const TransferState.initial()));
      });

      test('clearForm should clear form fields and reset state', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        // Set form values
        viewModel.updateRecipient(testToAddress.hex);
        viewModel.updateAmount('1.0');

        // Act
        viewModel.clearForm();

        // Assert
        expect(viewModel.recipientAddress, isEmpty);
        expect(viewModel.amount, isEmpty);

        final finalState = container.read(transferViewModelProvider);
        expect(finalState, equals(const TransferState.initial()));
      });

      test('transferStatus should return correct status', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        expect(viewModel.transferStatus, equals('Ready'));

        viewModel.state = TransferState.loading(
          recipient: testToAddress,
          amount: testTransferAmount,
        );
        expect(viewModel.transferStatus, equals('Sending...'));

        viewModel.state = TransferState.success(
          transactionHash: '0xabcdef',
          recipient: testToAddress,
          amount: testTransferAmount,
        );
        expect(viewModel.transferStatus, equals('Success'));

        viewModel.state = const TransferState.error(message: 'Test error');
        expect(viewModel.transferStatus, equals('Error'));
      });

      test('isTransferInProgress should return correct value', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        expect(viewModel.isTransferInProgress, isFalse);

        viewModel.state = TransferState.loading(
          recipient: testToAddress,
          amount: testTransferAmount,
        );
        expect(viewModel.isTransferInProgress, isTrue);
      });

      test('transactionHash should return hash when successful', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        expect(viewModel.transactionHash, isNull);

        const txHash = '0xabcdef1234567890';
        viewModel.state = TransferState.success(
          transactionHash: txHash,
          recipient: testToAddress,
          amount: testTransferAmount,
        );
        expect(viewModel.transactionHash, equals(txHash));
      });

      test('errorMessage should return message when in error state', () {
        final viewModel = container.read(transferViewModelProvider.notifier);

        expect(viewModel.errorMessage, isNull);

        const errorMsg = 'Test error message';
        viewModel.state = const TransferState.error(message: errorMsg);
        expect(viewModel.errorMessage, equals(errorMsg));
      });
    });
  });
}
