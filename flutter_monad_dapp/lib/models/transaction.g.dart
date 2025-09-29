// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TransactionImpl _$$TransactionImplFromJson(Map<String, dynamic> json) =>
    _$TransactionImpl(
      hash: json['hash'] as String,
      from: const EthereumAddressConverter().fromJson(json['from'] as String),
      to: const EthereumAddressConverter().fromJson(json['to'] as String),
      value: const EtherAmountConverter().fromJson(json['value'] as String),
      timestamp: const DateTimeConverter().fromJson(
        json['timestamp'] as String,
      ),
      status: $enumDecode(_$TransactionStatusEnumMap, json['status']),
      blockNumber: (json['block_number'] as num?)?.toInt(),
      gasUsed: json['gas_used'] == null
          ? null
          : BigInt.parse(json['gas_used'] as String),
      gasPrice: _$JsonConverterFromJson<String, EtherAmount>(
        json['gas_price'],
        const EtherAmountConverter().fromJson,
      ),
    );

Map<String, dynamic> _$$TransactionImplToJson(_$TransactionImpl instance) =>
    <String, dynamic>{
      'hash': instance.hash,
      'from': const EthereumAddressConverter().toJson(instance.from),
      'to': const EthereumAddressConverter().toJson(instance.to),
      'value': const EtherAmountConverter().toJson(instance.value),
      'timestamp': const DateTimeConverter().toJson(instance.timestamp),
      'status': _$TransactionStatusEnumMap[instance.status]!,
      'block_number': instance.blockNumber,
      'gas_used': instance.gasUsed?.toString(),
      'gas_price': _$JsonConverterToJson<String, EtherAmount>(
        instance.gasPrice,
        const EtherAmountConverter().toJson,
      ),
    };

const _$TransactionStatusEnumMap = {
  TransactionStatus.pending: 'pending',
  TransactionStatus.confirmed: 'confirmed',
  TransactionStatus.failed: 'failed',
  TransactionStatus.dropped: 'dropped',
};

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
