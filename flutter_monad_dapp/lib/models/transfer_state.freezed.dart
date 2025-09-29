// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transfer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TransferState _$TransferStateFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'initial':
      return _Initial.fromJson(json);
    case 'loading':
      return _Loading.fromJson(json);
    case 'success':
      return _Success.fromJson(json);
    case 'error':
      return _Error.fromJson(json);

    default:
      throw CheckedFromJsonException(
        json,
        'runtimeType',
        'TransferState',
        'Invalid union type "${json['runtimeType']}"!',
      );
  }
}

/// @nodoc
mixin _$TransferState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    loading,
    required TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    success,
    required TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult? Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult? Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;

  /// Serializes this TransferState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransferStateCopyWith<$Res> {
  factory $TransferStateCopyWith(
    TransferState value,
    $Res Function(TransferState) then,
  ) = _$TransferStateCopyWithImpl<$Res, TransferState>;
}

/// @nodoc
class _$TransferStateCopyWithImpl<$Res, $Val extends TransferState>
    implements $TransferStateCopyWith<$Res> {
  _$TransferStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
    _$InitialImpl value,
    $Res Function(_$InitialImpl) then,
  ) = __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
    _$InitialImpl _value,
    $Res Function(_$InitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
@JsonSerializable()
class _$InitialImpl implements _Initial {
  const _$InitialImpl({final String? $type}) : $type = $type ?? 'initial';

  factory _$InitialImpl.fromJson(Map<String, dynamic> json) =>
      _$$InitialImplFromJson(json);

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TransferState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    loading,
    required TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    success,
    required TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )
    error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult? Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult? Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InitialImplToJson(this);
  }
}

abstract class _Initial implements TransferState {
  const factory _Initial() = _$InitialImpl;

  factory _Initial.fromJson(Map<String, dynamic> json) = _$InitialImpl.fromJson;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
    _$LoadingImpl value,
    $Res Function(_$LoadingImpl) then,
  ) = __$$LoadingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    @EthereumAddressConverter() EthereumAddress recipient,
    @EtherAmountConverter() EtherAmount amount,
  });
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
    _$LoadingImpl _value,
    $Res Function(_$LoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? recipient = null, Object? amount = null}) {
    return _then(
      _$LoadingImpl(
        recipient: null == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as EthereumAddress,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as EtherAmount,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoadingImpl implements _Loading {
  const _$LoadingImpl({
    @EthereumAddressConverter() required this.recipient,
    @EtherAmountConverter() required this.amount,
    final String? $type,
  }) : $type = $type ?? 'loading';

  factory _$LoadingImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoadingImplFromJson(json);

  @override
  @EthereumAddressConverter()
  final EthereumAddress recipient;
  @override
  @EtherAmountConverter()
  final EtherAmount amount;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TransferState.loading(recipient: $recipient, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadingImpl &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, recipient, amount);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      __$$LoadingImplCopyWithImpl<_$LoadingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    loading,
    required TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    success,
    required TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )
    error,
  }) {
    return loading(recipient, amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult? Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult? Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
  }) {
    return loading?.call(recipient, amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(recipient, amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LoadingImplToJson(this);
  }
}

abstract class _Loading implements TransferState {
  const factory _Loading({
    @EthereumAddressConverter() required final EthereumAddress recipient,
    @EtherAmountConverter() required final EtherAmount amount,
  }) = _$LoadingImpl;

  factory _Loading.fromJson(Map<String, dynamic> json) = _$LoadingImpl.fromJson;

  @EthereumAddressConverter()
  EthereumAddress get recipient;
  @EtherAmountConverter()
  EtherAmount get amount;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadingImplCopyWith<_$LoadingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SuccessImplCopyWith<$Res> {
  factory _$$SuccessImplCopyWith(
    _$SuccessImpl value,
    $Res Function(_$SuccessImpl) then,
  ) = __$$SuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String transactionHash,
    @EthereumAddressConverter() EthereumAddress recipient,
    @EtherAmountConverter() EtherAmount amount,
  });
}

/// @nodoc
class __$$SuccessImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$SuccessImpl>
    implements _$$SuccessImplCopyWith<$Res> {
  __$$SuccessImplCopyWithImpl(
    _$SuccessImpl _value,
    $Res Function(_$SuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionHash = null,
    Object? recipient = null,
    Object? amount = null,
  }) {
    return _then(
      _$SuccessImpl(
        transactionHash: null == transactionHash
            ? _value.transactionHash
            : transactionHash // ignore: cast_nullable_to_non_nullable
                  as String,
        recipient: null == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as EthereumAddress,
        amount: null == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as EtherAmount,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SuccessImpl implements _Success {
  const _$SuccessImpl({
    required this.transactionHash,
    @EthereumAddressConverter() required this.recipient,
    @EtherAmountConverter() required this.amount,
    final String? $type,
  }) : $type = $type ?? 'success';

  factory _$SuccessImpl.fromJson(Map<String, dynamic> json) =>
      _$$SuccessImplFromJson(json);

  @override
  final String transactionHash;
  @override
  @EthereumAddressConverter()
  final EthereumAddress recipient;
  @override
  @EtherAmountConverter()
  final EtherAmount amount;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TransferState.success(transactionHash: $transactionHash, recipient: $recipient, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SuccessImpl &&
            (identical(other.transactionHash, transactionHash) ||
                other.transactionHash == transactionHash) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, transactionHash, recipient, amount);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      __$$SuccessImplCopyWithImpl<_$SuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    loading,
    required TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    success,
    required TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )
    error,
  }) {
    return success(transactionHash, recipient, amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult? Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult? Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
  }) {
    return success?.call(transactionHash, recipient, amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(transactionHash, recipient, amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SuccessImplToJson(this);
  }
}

abstract class _Success implements TransferState {
  const factory _Success({
    required final String transactionHash,
    @EthereumAddressConverter() required final EthereumAddress recipient,
    @EtherAmountConverter() required final EtherAmount amount,
  }) = _$SuccessImpl;

  factory _Success.fromJson(Map<String, dynamic> json) = _$SuccessImpl.fromJson;

  String get transactionHash;
  @EthereumAddressConverter()
  EthereumAddress get recipient;
  @EtherAmountConverter()
  EtherAmount get amount;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SuccessImplCopyWith<_$SuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
    _$ErrorImpl value,
    $Res Function(_$ErrorImpl) then,
  ) = __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({
    String message,
    @EthereumAddressConverter() EthereumAddress? recipient,
    @EtherAmountConverter() EtherAmount? amount,
  });
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$TransferStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
    _$ErrorImpl _value,
    $Res Function(_$ErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? recipient = freezed,
    Object? amount = freezed,
  }) {
    return _then(
      _$ErrorImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        recipient: freezed == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as EthereumAddress?,
        amount: freezed == amount
            ? _value.amount
            : amount // ignore: cast_nullable_to_non_nullable
                  as EtherAmount?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorImpl implements _Error {
  const _$ErrorImpl({
    required this.message,
    @EthereumAddressConverter() this.recipient,
    @EtherAmountConverter() this.amount,
    final String? $type,
  }) : $type = $type ?? 'error';

  factory _$ErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorImplFromJson(json);

  @override
  final String message;
  @override
  @EthereumAddressConverter()
  final EthereumAddress? recipient;
  @override
  @EtherAmountConverter()
  final EtherAmount? amount;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'TransferState.error(message: $message, recipient: $recipient, amount: $amount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, recipient, amount);

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    loading,
    required TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )
    success,
    required TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )
    error,
  }) {
    return error(message, recipient, amount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult? Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult? Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
  }) {
    return error?.call(message, recipient, amount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    loading,
    TResult Function(
      String transactionHash,
      @EthereumAddressConverter() EthereumAddress recipient,
      @EtherAmountConverter() EtherAmount amount,
    )?
    success,
    TResult Function(
      String message,
      @EthereumAddressConverter() EthereumAddress? recipient,
      @EtherAmountConverter() EtherAmount? amount,
    )?
    error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, recipient, amount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Success value) success,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Success value)? success,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Success value)? success,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorImplToJson(this);
  }
}

abstract class _Error implements TransferState {
  const factory _Error({
    required final String message,
    @EthereumAddressConverter() final EthereumAddress? recipient,
    @EtherAmountConverter() final EtherAmount? amount,
  }) = _$ErrorImpl;

  factory _Error.fromJson(Map<String, dynamic> json) = _$ErrorImpl.fromJson;

  String get message;
  @EthereumAddressConverter()
  EthereumAddress? get recipient;
  @EtherAmountConverter()
  EtherAmount? get amount;

  /// Create a copy of TransferState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
