import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_entity.freezed.dart';

@freezed
class LocationEntity with _$LocationEntity {
  const factory LocationEntity({
    @Default(0) double latitude,
    @Default(0) double longitude,
  }) = _LocationEntity;
}
