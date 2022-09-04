import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/data/data_sources/implemented/location_data_source_imp.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

final locationDS = Provider<LocationDS>((ref) {
  return LocationDataSourceGeolocator();
});

abstract class LocationDS {
  Future<bool> permited();

  Future<LocationEntity> getLocation();
}
