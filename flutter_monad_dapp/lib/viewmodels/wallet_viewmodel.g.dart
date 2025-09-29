// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$walletServiceHash() => r'f27286998577e9ca9e3cdfcd736ee04feba2ba75';

/// Provider for accessing the WalletService instance
///
/// Copied from [walletService].
@ProviderFor(walletService)
final walletServiceProvider = AutoDisposeProvider<WalletService>.internal(
  walletService,
  name: r'walletServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$walletServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WalletServiceRef = AutoDisposeProviderRef<WalletService>;
String _$web3ServiceHash() => r'834bd79218261c2f75f17f0e5ac50429d4453b6b';

/// Provider for accessing the Web3Service instance
///
/// Copied from [web3Service].
@ProviderFor(web3Service)
final web3ServiceProvider = AutoDisposeProvider<Web3Service>.internal(
  web3Service,
  name: r'web3ServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$web3ServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef Web3ServiceRef = AutoDisposeProviderRef<Web3Service>;
String _$walletViewModelHash() => r'81501084357c0ad66a6468f49c2ae033d1543d2e';

/// Riverpod AsyncNotifier for wallet state management
/// Handles wallet connection, disconnection, and balance refresh functionality
///
/// Copied from [WalletViewModel].
@ProviderFor(WalletViewModel)
final walletViewModelProvider =
    AutoDisposeNotifierProvider<WalletViewModel, WalletState>.internal(
      WalletViewModel.new,
      name: r'walletViewModelProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$walletViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WalletViewModel = AutoDisposeNotifier<WalletState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
