import 'package:freezed_annotation/freezed_annotation.dart';

part 'constellation_entity.freezed.dart';

@freezed
class ConstellationEntity with _$ConstellationEntity {
  const factory ConstellationEntity({
    required String cod,
    required String name,
  }) = _ConstellationEntity;
}
