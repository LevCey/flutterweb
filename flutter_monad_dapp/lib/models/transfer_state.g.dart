// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InitialImpl _$$InitialImplFromJson(Map<String, dynamic> json) =>
    _$InitialImpl($type: json['runtimeType'] as String?);

Map<String, dynamic> _$$InitialImplToJson(_$InitialImpl instance) =>
    <String, dynamic>{'runtimeType': instance.$type};

_$LoadingImpl _$$LoadingImplFromJson(Map<String, dynamic> json) =>
    _$LoadingImpl(
      recipient: const EthereumAddressConverter().fromJson(
        json['recipient'] as String,
      ),
      amount: const EtherAmountConverter().fromJson(json['amount'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$LoadingImplToJson(_$LoadingImpl instance) =>
    <String, dynamic>{
      'recipient': const EthereumAddressConverter().toJson(instance.recipient),
      'amount': const EtherAmountConverter().toJson(instance.amount),
      'runtimeType': instance.$type,
    };

_$SuccessImpl _$$SuccessImplFromJson(Map<String, dynamic> json) =>
    _$SuccessImpl(
      transactionHash: json['transaction_hash'] as String,
      recipient: const EthereumAddressConverter().fromJson(
        json['recipient'] as String,
      ),
      amount: const EtherAmountConverter().fromJson(json['amount'] as String),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$SuccessImplToJson(_$SuccessImpl instance) =>
    <String, dynamic>{
      'transaction_hash': instance.transactionHash,
      'recipient': const EthereumAddressConverter().toJson(instance.recipient),
      'amount': const EtherAmountConverter().toJson(instance.amount),
      'runtimeType': instance.$type,
    };

_$ErrorImpl _$$ErrorImplFromJson(Map<String, dynamic> json) => _$ErrorImpl(
  message: json['message'] as String,
  recipient: _$JsonConverterFromJson<String, EthereumAddress>(
    json['recipient'],
    const EthereumAddressConverter().fromJson,
  ),
  amount: _$JsonConverterFromJson<String, EtherAmount>(
    json['amount'],
    const EtherAmountConverter().fromJson,
  ),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$$ErrorImplToJson(_$ErrorImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'recipient': _$JsonConverterToJson<String, EthereumAddress>(
        instance.recipient,
        const EthereumAddressConverter().toJson,
      ),
      'amount': _$JsonConverterToJson<String, EtherAmount>(
        instance.amount,
        const EtherAmountConverter().toJson,
      ),
      'runtimeType': instance.$type,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
