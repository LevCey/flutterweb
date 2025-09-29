import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/json_converters.dart';

part 'wallet_state.freezed.dart';
part 'wallet_state.g.dart';

/// Represents the different states of wallet connection and interaction
/// This is a union type using Freezed for immutable state management
@freezed
class WalletState with _$WalletState {
  /// Initial state when the app starts, no wallet connection attempted
  const factory WalletState.initial() = _Initial;

  /// State when attempting to connect to a wallet
  const factory WalletState.connecting() = _Connecting;

  /// State when wallet is successfully connected with address and balance
  const factory WalletState.connected({
    @EthereumAddressConverter() required EthereumAddress address,
    @EtherAmountConverter() required EtherAmount balance,
  }) = _Connected;

  /// State when wallet is disconnected
  const factory WalletState.disconnected() = _Disconnected;

  /// State when an error occurs during wallet operations
  const factory WalletState.error(String message) = _Error;

  /// JSON serialization support
  factory WalletState.fromJson(Map<String, dynamic> json) =>
      _$WalletStateFromJson(json);
}
