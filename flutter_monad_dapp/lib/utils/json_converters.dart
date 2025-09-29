import 'package:json_annotation/json_annotation.dart';
import 'package:web3dart/web3dart.dart';

/// JSON converter for EthereumAddress
class EthereumAddressConverter
    implements JsonConverter<EthereumAddress, String> {
  const EthereumAddressConverter();

  @override
  EthereumAddress fromJson(String json) {
    return EthereumAddress.fromHex(json);
  }

  @override
  String toJson(EthereumAddress object) {
    return object.hex;
  }
}

/// JSON converter for EtherAmount
class EtherAmountConverter implements JsonConverter<EtherAmount, String> {
  const EtherAmountConverter();

  @override
  EtherAmount fromJson(String json) {
    return EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(json));
  }

  @override
  String toJson(EtherAmount object) {
    return object.getInWei.toString();
  }
}

/// JSON converter for DateTime
class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    return object.toIso8601String();
  }
}
