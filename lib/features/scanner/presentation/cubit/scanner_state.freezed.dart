// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scanner_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it dessertation.');

/// @nodoc
mixin _$ScannerState {
  ScannerStatus get status => throw _privateConstructorUsedError;
  GroupEntity? get currentGroup => throw _privateConstructorUsedError;
  List<GroupEntity> get sessionGroups => throw _privateConstructorUsedError;
  int get currentGroupImageCount => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScannerStateCopyWith<ScannerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScannerStateCopyWith<$Res> {
  factory $ScannerStateCopyWith(
          ScannerState value, $Res Function(ScannerState) then) =
      _$ScannerStateCopyWithImpl<$Res, ScannerState>;
  @useResult
  $Res call(
      {ScannerStatus status,
      GroupEntity? currentGroup,
      List<GroupEntity> sessionGroups,
      int currentGroupImageCount,
      String? errorMessage});
}

/// @nodoc
class _$ScannerStateCopyWithImpl<$Res, $Val extends ScannerState>
    implements $ScannerStateCopyWith<$Res> {
  _$ScannerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentGroup = freezed,
    Object? sessionGroups = null,
    Object? currentGroupImageCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScannerStatus,
      currentGroup: freezed == currentGroup
          ? _value.currentGroup
          : currentGroup // ignore: cast_nullable_to_non_nullable
              as GroupEntity?,
      sessionGroups: null == sessionGroups
          ? _value.sessionGroups
          : sessionGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupEntity>,
      currentGroupImageCount: null == currentGroupImageCount
          ? _value.currentGroupImageCount
          : currentGroupImageCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScannerStateImplCopyWith<$Res>
    implements $ScannerStateCopyWith<$Res> {
  factory _$$ScannerStateImplCopyWith(
          _$ScannerStateImpl value, $Res Function(_$ScannerStateImpl) then) =
      __$$ScannerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ScannerStatus status,
      GroupEntity? currentGroup,
      List<GroupEntity> sessionGroups,
      int currentGroupImageCount,
      String? errorMessage});
}

/// @nodoc
class __$$ScannerStateImplCopyWithImpl<$Res>
    extends _$ScannerStateCopyWithImpl<$Res, _$ScannerStateImpl>
    implements _$$ScannerStateImplCopyWith<$Res> {
  __$$ScannerStateImplCopyWithImpl(
      _$ScannerStateImpl _value, $Res Function(_$ScannerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? currentGroup = freezed,
    Object? sessionGroups = null,
    Object? currentGroupImageCount = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$ScannerStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ScannerStatus,
      currentGroup: freezed == currentGroup
          ? _value.currentGroup
          : currentGroup // ignore: cast_nullable_to_non_nullable
              as GroupEntity?,
      sessionGroups: null == sessionGroups
          ? _value._sessionGroups
          : sessionGroups // ignore: cast_nullable_to_non_nullable
              as List<GroupEntity>,
      currentGroupImageCount: null == currentGroupImageCount
          ? _value.currentGroupImageCount
          : currentGroupImageCount // ignore: cast_nullable_to_non_nullable
              as int,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ScannerStateImpl implements _ScannerState {
  const _$ScannerStateImpl(
      {this.status = ScannerStatus.initial,
      this.currentGroup,
      final List<GroupEntity> sessionGroups = const [],
      this.currentGroupImageCount = 0,
      this.errorMessage})
      : _sessionGroups = sessionGroups;

  @override
  @JsonKey()
  final ScannerStatus status;
  @override
  final GroupEntity? currentGroup;
  final List<GroupEntity> _sessionGroups;
  @override
  @JsonKey()
  List<GroupEntity> get sessionGroups {
    if (_sessionGroups is EqualUnmodifiableListView) return _sessionGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sessionGroups);
  }

  @override
  @JsonKey()
  final int currentGroupImageCount;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ScannerState(status: $status, currentGroup: $currentGroup, sessionGroups: $sessionGroups, currentGroupImageCount: $currentGroupImageCount, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScannerStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.currentGroup, currentGroup) ||
                other.currentGroup == currentGroup) &&
            const DeepCollectionEquality()
                .equals(other._sessionGroups, _sessionGroups) &&
            (identical(other.currentGroupImageCount, currentGroupImageCount) ||
                other.currentGroupImageCount == currentGroupImageCount) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      currentGroup,
      const DeepCollectionEquality().hash(_sessionGroups),
      currentGroupImageCount,
      errorMessage);

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScannerStateImplCopyWith<_$ScannerStateImpl> get copyWith =>
      __$$ScannerStateImplCopyWithImpl<_$ScannerStateImpl>(this, _$identity);
}

abstract class _ScannerState implements ScannerState {
  const factory _ScannerState(
      {final ScannerStatus status,
      final GroupEntity? currentGroup,
      final List<GroupEntity> sessionGroups,
      final int currentGroupImageCount,
      final String? errorMessage}) = _$ScannerStateImpl;

  @override
  ScannerStatus get status;
  @override
  GroupEntity? get currentGroup;
  @override
  List<GroupEntity> get sessionGroups;
  @override
  int get currentGroupImageCount;
  @override
  String? get errorMessage;

  /// Create a copy of ScannerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScannerStateImplCopyWith<_$ScannerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
