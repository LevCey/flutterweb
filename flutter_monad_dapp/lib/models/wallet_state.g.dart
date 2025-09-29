// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InitialImpl _$$InitialImplFromJson(Map<String, dynamic> json) =>
    _$InitialImpl($type: json['runtimeType'] as String?);

Map<String, dynamic> _$$InitialImplToJson(_$InitialImpl instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_$ConnectingImpl _$$ConnectingImplFromJson(Map<String, dynamic> json) =>
    _$ConnectingImpl($type: json['runtimeType'] as String?);

Map<String, dynamic> _$$ConnectingImplToJson(_$ConnectingImpl instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_$ConnectedImpl _$$ConnectedImplFromJson(Map<String, dynamic> json) =>
    _$ConnectedImpl(
      address: const EthereumAddressConverter().fromJson(
        json['address'] as String,
      ),
      balance: const EtherAmountConverter().fromJson(json['balance'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ConnectedImplToJson(_$ConnectedImpl instance) =>
    <String, dynamic>{
      'address': const EthereumAddressConverter().toJson(instance.address),
      'balance': const EtherAmountConverter().toJson(instance.balance),
      'runtimeType': instance.$type,
    };

_$DisconnectedImpl _$$DisconnectedImplFromJson(Map<String, dynamic> json) =>
    _$DisconnectedImpl($type: json['runtimeType'] as String?);

Map<String, dynamic> _$$DisconnectedImplToJson(_$DisconnectedImpl instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
  json['message'] as String,
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };
