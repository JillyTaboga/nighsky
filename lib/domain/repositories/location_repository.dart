import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/data/data_sources/abstracts/location_ds.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

final locationRepository = Provider<LocationRepository>(((ref) {
  final dataSource = ref.watch(locationDS);
  return LocationRepository(dataSource);
}));

class LocationRepository {
  LocationRepository(this._locationDS);
  final LocationDS _locationDS;

  Future<bool> isPermitted() async {
    try {
      return await _locationDS.permited();
    } catch (e) {
      throw Exception('Sistema de localização indisponível');
    }
  }

  Future<LocationEntity> getLocation() async {
    try {
      return await _locationDS.getLocation();
    } catch (e) {
      throw Exception('Sistema de localização indisponível');
    }
  }
}
