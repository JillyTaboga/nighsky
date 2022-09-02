// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'constellation_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ConstellationEntity {
  String get cod => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConstellationEntityCopyWith<ConstellationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConstellationEntityCopyWith<$Res> {
  factory $ConstellationEntityCopyWith(
          ConstellationEntity value, $Res Function(ConstellationEntity) then) =
      _$ConstellationEntityCopyWithImpl<$Res>;
  $Res call({String cod, String name});
}

/// @nodoc
class _$ConstellationEntityCopyWithImpl<$Res>
    implements $ConstellationEntityCopyWith<$Res> {
  _$ConstellationEntityCopyWithImpl(this._value, this._then);

  final ConstellationEntity _value;
  // ignore: unused_field
  final $Res Function(ConstellationEntity) _then;

  @override
  $Res call({
    Object? cod = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      cod: cod == freezed
          ? _value.cod
          : cod // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_ConstellationEntityCopyWith<$Res>
    implements $ConstellationEntityCopyWith<$Res> {
  factory _$$_ConstellationEntityCopyWith(_$_ConstellationEntity value,
          $Res Function(_$_ConstellationEntity) then) =
      __$$_ConstellationEntityCopyWithImpl<$Res>;
  @override
  $Res call({String cod, String name});
}

/// @nodoc
class __$$_ConstellationEntityCopyWithImpl<$Res>
    extends _$ConstellationEntityCopyWithImpl<$Res>
    implements _$$_ConstellationEntityCopyWith<$Res> {
  __$$_ConstellationEntityCopyWithImpl(_$_ConstellationEntity _value,
      $Res Function(_$_ConstellationEntity) _then)
      : super(_value, (v) => _then(v as _$_ConstellationEntity));

  @override
  _$_ConstellationEntity get _value => super._value as _$_ConstellationEntity;

  @override
  $Res call({
    Object? cod = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_ConstellationEntity(
      cod: cod == freezed
          ? _value.cod
          : cod // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ConstellationEntity implements _ConstellationEntity {
  const _$_ConstellationEntity({required this.cod, required this.name});

  @override
  final String cod;
  @override
  final String name;

  @override
  String toString() {
    return 'ConstellationEntity(cod: $cod, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConstellationEntity &&
            const DeepCollectionEquality().equals(other.cod, cod) &&
            const DeepCollectionEquality().equals(other.name, name));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(cod),
      const DeepCollectionEquality().hash(name));

  @JsonKey(ignore: true)
  @override
  _$$_ConstellationEntityCopyWith<_$_ConstellationEntity> get copyWith =>
      __$$_ConstellationEntityCopyWithImpl<_$_ConstellationEntity>(
          this, _$identity);
}

abstract class _ConstellationEntity implements ConstellationEntity {
  const factory _ConstellationEntity(
      {required final String cod,
      required final String name}) = _$_ConstellationEntity;

  @override
  String get cod;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$_ConstellationEntityCopyWith<_$_ConstellationEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
