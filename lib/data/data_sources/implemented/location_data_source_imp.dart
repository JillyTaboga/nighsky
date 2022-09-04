import 'package:geolocator/geolocator.dart';
import 'package:nighsky/data/data_sources/abstracts/location_ds.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

class LocationDataSourceGeolocator implements LocationDS {
  @override
  Future<bool> permited() async {
    final isPermited = await Geolocator.isLocationServiceEnabled();
    if (isPermited) {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Future<LocationEntity> getLocation() async {
    final location = await Geolocator.getCurrentPosition();
    return LocationEntity(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }
}
