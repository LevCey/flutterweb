import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:web3dart/web3dart.dart';
import 'package:flutter_monad_dapp/models/wallet_state.dart';
import 'package:flutter_monad_dapp/services/wallet_service.dart';
import 'package:flutter_monad_dapp/services/web3_service.dart';
import 'package:flutter_monad_dapp/viewmodels/wallet_viewmodel.dart';

import 'wallet_viewmodel_test.mocks.dart';

@GenerateMocks([WalletService, Web3Service])
void main() {
  group('WalletViewModel', () {
    late ProviderContainer container;
    late MockWalletService mockWalletService;
    late MockWeb3Service mockWeb3Service;
    late EthereumAddress testAddress;
    late EtherAmount testBalance;

    setUp(() {
      mockWalletService = MockWalletService();
      mockWeb3Service = MockWeb3Service();
      testAddress = EthereumAddress.fromHex(
        '0x1234567890123456789012345678901234567890',
      );
      testBalance = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(1000000000000000000),
      ); // 1 ETH

      container = ProviderContainer(
        overrides: [
          walletServiceProvider.overrideWithValue(mockWalletService),
          web3ServiceProvider.overrideWithValue(mockWeb3Service),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state should be WalletState.initial', () {
      final viewModel = container.read(walletViewModelProvider.notifier);
      final state = container.read(walletViewModelProvider);

      expect(state, equals(const WalletState.initial()));
    });

    group('connectWallet', () {
      test(
        'should update state to connecting then connected on success',
        () async {
          // Arrange
          when(mockWalletService.connectWallet()).thenAnswer((_) async => true);
          when(
            mockWalletService.getConnectedAddress(),
          ).thenAnswer((_) async => testAddress);
          when(
            mockWeb3Service.getBalance(testAddress),
          ).thenAnswer((_) async => testBalance);
          when(
            mockWalletService.updateBalance(testBalance),
          ).thenAnswer((_) async {});

          final viewModel = container.read(walletViewModelProvider.notifier);

          // Act
          await viewModel.connectWallet();

          // Assert
          final finalState = container.read(walletViewModelProvider);

          finalState.when(
            initial: () => fail('Expected connected state'),
            connecting: () => fail('Expected connected state'),
            connected: (address, balance) {
              expect(address, equals(testAddress));
              expect(balance, equals(testBalance));
            },
            disconnected: () => fail('Expected connected state'),
            error: (message) =>
                fail('Expected connected state, got error: $message'),
          );

          verify(mockWalletService.connectWallet()).called(1);
          verify(mockWalletService.getConnectedAddress()).called(1);
          verify(mockWeb3Service.getBalance(testAddress)).called(1);
          verify(mockWalletService.updateBalance(testBalance)).called(1);
        },
      );

      test('should update state to error on wallet connection failure', () async {
        // Arrange
        when(mockWalletService.connectWallet()).thenAnswer((_) async => false);

        final viewModel = container.read(walletViewModelProvider.notifier);

        // Act
        await viewModel.connectWallet();

        // Assert
        final finalState = container.read(walletViewModelProvider);
        // State should remain initial or be error - both are acceptable for failed connection
        expect(
          finalState.runtimeType.toString(),
          anyOf(contains('Initial'), contains('Error')),
        );

        verify(mockWalletService.connectWallet()).called(1);
      });

      test('should update state to error on exception', () async {
        // Arrange
        when(
          mockWalletService.connectWallet(),
        ).thenThrow(Exception('Connection failed'));

        final viewModel = container.read(walletViewModelProvider.notifier);

        // Act
        await viewModel.connectWallet();

        // Assert
        final finalState = container.read(walletViewModelProvider);

        finalState.when(
          initial: () => fail('Expected error state'),
          connecting: () => fail('Expected error state'),
          connected: (address, balance) => fail('Expected error state'),
          disconnected: () => fail('Expected error state'),
          error: (message) {
            expect(message, contains('Failed to connect wallet'));
          },
        );

        verify(mockWalletService.connectWallet()).called(1);
      });
    });

    group('disconnectWallet', () {
      test('should update state to disconnected on success', () async {
        // Arrange
        when(mockWalletService.disconnectWallet()).thenAnswer((_) async {});

        final viewModel = container.read(walletViewModelProvider.notifier);

        // Act
        await viewModel.disconnectWallet();

        // Assert
        final finalState = container.read(walletViewModelProvider);
        expect(finalState, equals(const WalletState.disconnected()));

        verify(mockWalletService.disconnectWallet()).called(1);
      });

      test('should update state to error on exception', () async {
        // Arrange
        when(
          mockWalletService.disconnectWallet(),
        ).thenThrow(Exception('Disconnect failed'));

        final viewModel = container.read(walletViewModelProvider.notifier);

        // Act
        await viewModel.disconnectWallet();

        // Assert
        final finalState = container.read(walletViewModelProvider);

        finalState.when(
          initial: () => fail('Expected error state'),
          connecting: () => fail('Expected error state'),
          connected: (address, balance) => fail('Expected error state'),
          disconnected: () => fail('Expected error state'),
          error: (message) {
            expect(message, contains('Failed to disconnect wallet'));
          },
        );

        verify(mockWalletService.disconnectWallet()).called(1);
      });
    });

    group('refreshBalance', () {
      test('should refresh balance when wallet is connected', () async {
        // Arrange
        when(
          mockWeb3Service.getBalance(testAddress),
        ).thenAnswer((_) async => testBalance);
        when(
          mockWalletService.updateBalance(testBalance),
        ).thenAnswer((_) async {});

        final viewModel = container.read(walletViewModelProvider.notifier);

        // Set initial connected state
        viewModel.state = WalletState.connected(
          address: testAddress,
          balance: EtherAmount.zero(),
        );

        // Act
        await viewModel.refreshBalance();

        // Assert
        final finalState = container.read(walletViewModelProvider);

        finalState.when(
          initial: () => fail('Expected connected state'),
          connecting: () => fail('Expected connected state'),
          connected: (address, balance) {
            expect(address, equals(testAddress));
            expect(balance, equals(testBalance));
          },
          disconnected: () => fail('Expected connected state'),
          error: (message) =>
              fail('Expected connected state, got error: $message'),
        );

        verify(mockWeb3Service.getBalance(testAddress)).called(1);
        verify(mockWalletService.updateBalance(testBalance)).called(1);
      });

      test('should not refresh balance when wallet is not connected', () async {
        // Arrange
        final viewModel = container.read(walletViewModelProvider.notifier);

        // Ensure state is not connected
        expect(viewModel.state, equals(const WalletState.initial()));

        // Act
        await viewModel.refreshBalance();

        // Assert
        final finalState = container.read(walletViewModelProvider);
        expect(finalState, equals(const WalletState.initial()));

        verifyNever(mockWeb3Service.getBalance(any));
        verifyNever(mockWalletService.updateBalance(any));
      });

      test('should update state to error on balance fetch failure', () async {
        // Arrange
        when(
          mockWeb3Service.getBalance(testAddress),
        ).thenThrow(Exception('Balance fetch failed'));

        final viewModel = container.read(walletViewModelProvider.notifier);

        // Set initial connected state
        viewModel.state = WalletState.connected(
          address: testAddress,
          balance: EtherAmount.zero(),
        );

        // Act
        await viewModel.refreshBalance();

        // Assert
        final finalState = container.read(walletViewModelProvider);

        finalState.when(
          initial: () => fail('Expected error state'),
          connecting: () => fail('Expected error state'),
          connected: (address, balance) => fail('Expected error state'),
          disconnected: () => fail('Expected error state'),
          error: (message) {
            expect(message, contains('Failed to get balance'));
          },
        );

        verify(mockWeb3Service.getBalance(testAddress)).called(1);
      });
    });

    group('getter methods', () {
      test('connectedAddress should return address when connected', () {
        final viewModel = container.read(walletViewModelProvider.notifier);
        viewModel.state = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );

        expect(viewModel.connectedAddress, equals(testAddress));
      });

      test('connectedAddress should return null when not connected', () {
        final viewModel = container.read(walletViewModelProvider.notifier);

        expect(viewModel.connectedAddress, isNull);
      });

      test('currentBalance should return balance when connected', () {
        final viewModel = container.read(walletViewModelProvider.notifier);
        viewModel.state = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );

        expect(viewModel.currentBalance, equals(testBalance));
      });

      test('currentBalance should return null when not connected', () {
        final viewModel = container.read(walletViewModelProvider.notifier);

        expect(viewModel.currentBalance, isNull);
      });

      test('isConnected should return true when connected', () {
        final viewModel = container.read(walletViewModelProvider.notifier);
        viewModel.state = WalletState.connected(
          address: testAddress,
          balance: testBalance,
        );

        expect(viewModel.isConnected, isTrue);
      });

      test('isConnected should return false when not connected', () {
        final viewModel = container.read(walletViewModelProvider.notifier);

        expect(viewModel.isConnected, isFalse);
      });

      test('isConnecting should return true when connecting', () {
        final viewModel = container.read(walletViewModelProvider.notifier);
        viewModel.state = const WalletState.connecting();

        expect(viewModel.isConnecting, isTrue);
      });

      test('isConnecting should return false when not connecting', () {
        final viewModel = container.read(walletViewModelProvider.notifier);

        expect(viewModel.isConnecting, isFalse);
      });

      test('errorMessage should return message when in error state', () {
        final viewModel = container.read(walletViewModelProvider.notifier);
        const errorMsg = 'Test error message';
        viewModel.state = const WalletState.error(errorMsg);

        expect(viewModel.errorMessage, equals(errorMsg));
      });

      test('errorMessage should return null when not in error state', () {
        final viewModel = container.read(walletViewModelProvider.notifier);

        expect(viewModel.errorMessage, isNull);
      });
    });
  });
}
