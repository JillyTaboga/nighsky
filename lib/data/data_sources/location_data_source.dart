import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

final locationDataSource = Provider<LocationDataSource>((ref) {
  return LocationDataSource();
});

class LocationDataSource {
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

  Future<LocationEntity> getLocation() async {
    final location = await Geolocator.getCurrentPosition();
    return LocationEntity(
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }
}
