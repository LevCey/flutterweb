// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Transaction _$TransactionFromJson(Map<String, dynamic> json) {
  return _Transaction.fromJson(json);
}

/// @nodoc
mixin _$Transaction {
  /// Unique transaction hash on the blockchain
  String get hash => throw _privateConstructorUsedError;

  /// Address that sent the transaction
  @EthereumAddressConverter()
  EthereumAddress get from => throw _privateConstructorUsedError;

  /// Address that received the transaction
  @EthereumAddressConverter()
  EthereumAddress get to => throw _privateConstructorUsedError;

  /// Amount of tokens transferred
  @EtherAmountConverter()
  EtherAmount get value => throw _privateConstructorUsedError;

  /// Timestamp when the transaction was created/confirmed
  @DateTimeConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Current status of the transaction
  TransactionStatus get status => throw _privateConstructorUsedError;

  /// Optional block number where transaction was included
  int? get blockNumber => throw _privateConstructorUsedError;

  /// Optional gas used by the transaction
  BigInt? get gasUsed => throw _privateConstructorUsedError;

  /// Optional gas price used for the transaction
  @EtherAmountConverter()
  EtherAmount? get gasPrice => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      String hash,
      @EthereumAddressConverter() EthereumAddress from,
      @EthereumAddressConverter() EthereumAddress to,
      @EtherAmountConverter() EtherAmount value,
      @DateTimeConverter() DateTime timestamp,
      TransactionStatus status,
      int? blockNumber,
      BigInt? gasUsed,
      @EtherAmountConverter() EtherAmount? gasPrice,
    )
    $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      String hash,
      @EthereumAddressConverter() EthereumAddress from,
      @EthereumAddressConverter() EthereumAddress to,
      @EtherAmountConverter() EtherAmount value,
      @DateTimeConverter() DateTime timestamp,
      TransactionStatus status,
      int? blockNumber,
      BigInt? gasUsed,
      @EtherAmountConverter() EtherAmount? gasPrice,
    )?
    $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      String hash,
      @EthereumAddressConverter() EthereumAddress from,
      @EthereumAddressConverter() EthereumAddress to,
      @EtherAmountConverter() EtherAmount value,
      @DateTimeConverter() DateTime timestamp,
      TransactionStatus status,
      int? blockNumber,
      BigInt? gasUsed,
      @EtherAmountConverter() EtherAmount? gasPrice,
    )?
    $default, {
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Transaction value) $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Transaction value)? $default,
  ) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Transaction value)? $default, {
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this Transaction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionCopyWith<Transaction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionCopyWith<$Res> {
  factory $TransactionCopyWith(
    Transaction value,
    $Res Function(Transaction) then,
  ) = _$TransactionCopyWithImpl<$Res, Transaction>;
  @useResult
  $Res call({
    String hash,
    @EthereumAddressConverter() EthereumAddress from,
    @EthereumAddressConverter() EthereumAddress to,
    @EtherAmountConverter() EtherAmount value,
    @DateTimeConverter() DateTime timestamp,
    TransactionStatus status,
    int? blockNumber,
    BigInt? gasUsed,
    @EtherAmountConverter() EtherAmount? gasPrice,
  });
}

/// @nodoc
class _$TransactionCopyWithImpl<$Res, $Val extends Transaction>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? timestamp = null,
    Object? status = null,
    Object? blockNumber = freezed,
    Object? gasUsed = freezed,
    Object? gasPrice = freezed,
  }) {
    return _then(
      _value.copyWith(
            hash: null == hash
                ? _value.hash
                : hash // ignore: cast_nullable_to_non_nullable
                      as String,
            from: null == from
                ? _value.from
                : from // ignore: cast_nullable_to_non_nullable
                      as EthereumAddress,
            to: null == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                      as EthereumAddress,
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as EtherAmount,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as TransactionStatus,
            blockNumber: freezed == blockNumber
                ? _value.blockNumber
                : blockNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            gasUsed: freezed == gasUsed
                ? _value.gasUsed
                : gasUsed // ignore: cast_nullable_to_non_nullable
                      as BigInt?,
            gasPrice: freezed == gasPrice
                ? _value.gasPrice
                : gasPrice // ignore: cast_nullable_to_non_nullable
                      as EtherAmount?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TransactionImplCopyWith<$Res>
    implements $TransactionCopyWith<$Res> {
  factory _$$TransactionImplCopyWith(
    _$TransactionImpl value,
    $Res Function(_$TransactionImpl) then,
  ) = __$$TransactionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String hash,
    @EthereumAddressConverter() EthereumAddress from,
    @EthereumAddressConverter() EthereumAddress to,
    @EtherAmountConverter() EtherAmount value,
    @DateTimeConverter() DateTime timestamp,
    TransactionStatus status,
    int? blockNumber,
    BigInt? gasUsed,
    @EtherAmountConverter() EtherAmount? gasPrice,
  });
}

/// @nodoc
class __$$TransactionImplCopyWithImpl<$Res>
    extends _$TransactionCopyWithImpl<$Res, _$TransactionImpl>
    implements _$$TransactionImplCopyWith<$Res> {
  __$$TransactionImplCopyWithImpl(
    _$TransactionImpl _value,
    $Res Function(_$TransactionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hash = null,
    Object? from = null,
    Object? to = null,
    Object? value = null,
    Object? timestamp = null,
    Object? status = null,
    Object? blockNumber = freezed,
    Object? gasUsed = freezed,
    Object? gasPrice = freezed,
  }) {
    return _then(
      _$TransactionImpl(
        hash: null == hash
            ? _value.hash
            : hash // ignore: cast_nullable_to_non_nullable
                  as String,
        from: null == from
            ? _value.from
            : from // ignore: cast_nullable_to_non_nullable
                  as EthereumAddress,
        to: null == to
            ? _value.to
            : to // ignore: cast_nullable_to_non_nullable
                  as EthereumAddress,
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as EtherAmount,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as TransactionStatus,
        blockNumber: freezed == blockNumber
            ? _value.blockNumber
            : blockNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        gasUsed: freezed == gasUsed
            ? _value.gasUsed
            : gasUsed // ignore: cast_nullable_to_non_nullable
                  as BigInt?,
        gasPrice: freezed == gasPrice
            ? _value.gasPrice
            : gasPrice // ignore: cast_nullable_to_non_nullable
                  as EtherAmount?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionImpl implements _Transaction {
  const _$TransactionImpl({
    required this.hash,
    @EthereumAddressConverter() required this.from,
    @EthereumAddressConverter() required this.to,
    @EtherAmountConverter() required this.value,
    @DateTimeConverter() required this.timestamp,
    required this.status,
    this.blockNumber,
    this.gasUsed,
    @EtherAmountConverter() this.gasPrice,
  });

  factory _$TransactionImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionImplFromJson(json);

  /// Unique transaction hash on the blockchain
  @override
  final String hash;

  /// Address that sent the transaction
  @override
  @EthereumAddressConverter()
  final EthereumAddress from;

  /// Address that received the transaction
  @override
  @EthereumAddressConverter()
  final EthereumAddress to;

  /// Amount of tokens transferred
  @override
  @EtherAmountConverter()
  final EtherAmount value;

  /// Timestamp when the transaction was created/confirmed
  @override
  @DateTimeConverter()
  final DateTime timestamp;

  /// Current status of the transaction
  @override
  final TransactionStatus status;

  /// Optional block number where transaction was included
  @override
  final int? blockNumber;

  /// Optional gas used by the transaction
  @override
  final BigInt? gasUsed;

  /// Optional gas price used for the transaction
  @override
  @EtherAmountConverter()
  final EtherAmount? gasPrice;

  @override
  String toString() {
    return 'Transaction(hash: $hash, from: $from, to: $to, value: $value, timestamp: $timestamp, status: $status, blockNumber: $blockNumber, gasUsed: $gasUsed, gasPrice: $gasPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionImpl &&
            (identical(other.hash, hash) || other.hash == hash) &&
            (identical(other.from, from) || other.from == from) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.blockNumber, blockNumber) ||
                other.blockNumber == blockNumber) &&
            (identical(other.gasUsed, gasUsed) || other.gasUsed == gasUsed) &&
            (identical(other.gasPrice, gasPrice) ||
                other.gasPrice == gasPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    hash,
    from,
    to,
    value,
    timestamp,
    status,
    blockNumber,
    gasUsed,
    gasPrice,
  );

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      __$$TransactionImplCopyWithImpl<_$TransactionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
      String hash,
      @EthereumAddressConverter() EthereumAddress from,
      @EthereumAddressConverter() EthereumAddress to,
      @EtherAmountConverter() EtherAmount value,
      @DateTimeConverter() DateTime timestamp,
      TransactionStatus status,
      int? blockNumber,
      BigInt? gasUsed,
      @EtherAmountConverter() EtherAmount? gasPrice,
    )
    $default,
  ) {
    return $default(
      hash,
      from,
      to,
      value,
      timestamp,
      status,
      blockNumber,
      gasUsed,
      gasPrice,
    );
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
      String hash,
      @EthereumAddressConverter() EthereumAddress from,
      @EthereumAddressConverter() EthereumAddress to,
      @EtherAmountConverter() EtherAmount value,
      @DateTimeConverter() DateTime timestamp,
      TransactionStatus status,
      int? blockNumber,
      BigInt? gasUsed,
      @EtherAmountConverter() EtherAmount? gasPrice,
    )?
    $default,
  ) {
    return $default?.call(
      hash,
      from,
      to,
      value,
      timestamp,
      status,
      blockNumber,
      gasUsed,
      gasPrice,
    );
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
      String hash,
      @EthereumAddressConverter() EthereumAddress from,
      @EthereumAddressConverter() EthereumAddress to,
      @EtherAmountConverter() EtherAmount value,
      @DateTimeConverter() DateTime timestamp,
      TransactionStatus status,
      int? blockNumber,
      BigInt? gasUsed,
      @EtherAmountConverter() EtherAmount? gasPrice,
    )?
    $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
        hash,
        from,
        to,
        value,
        timestamp,
        status,
        blockNumber,
        gasUsed,
        gasPrice,
      );
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Transaction value) $default,
  ) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Transaction value)? $default,
  ) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Transaction value)? $default, {
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionImplToJson(this);
  }
}

abstract class _Transaction implements Transaction {
  const factory _Transaction({
    required final String hash,
    @EthereumAddressConverter() required final EthereumAddress from,
    @EthereumAddressConverter() required final EthereumAddress to,
    @EtherAmountConverter() required final EtherAmount value,
    @DateTimeConverter() required final DateTime timestamp,
    required final TransactionStatus status,
    final int? blockNumber,
    final BigInt? gasUsed,
    @EtherAmountConverter() final EtherAmount? gasPrice,
  }) = _$TransactionImpl;

  factory _Transaction.fromJson(Map<String, dynamic> json) =
      _$TransactionImpl.fromJson;

  /// Unique transaction hash on the blockchain
  @override
  String get hash;

  /// Address that sent the transaction
  @override
  @EthereumAddressConverter()
  EthereumAddress get from;

  /// Address that received the transaction
  @override
  @EthereumAddressConverter()
  EthereumAddress get to;

  /// Amount of tokens transferred
  @override
  @EtherAmountConverter()
  EtherAmount get value;

  /// Timestamp when the transaction was created/confirmed
  @override
  @DateTimeConverter()
  DateTime get timestamp;

  /// Current status of the transaction
  @override
  TransactionStatus get status;

  /// Optional block number where transaction was included
  @override
  int? get blockNumber;

  /// Optional gas used by the transaction
  @override
  BigInt? get gasUsed;

  /// Optional gas price used for the transaction
  @override
  @EtherAmountConverter()
  EtherAmount? get gasPrice;

  /// Create a copy of Transaction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionImplCopyWith<_$TransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
