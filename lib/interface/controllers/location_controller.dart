import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/entities/location_entity.dart';
import 'package:nighsky/domain/use_cases/location/getLocation.dart';
import 'package:nighsky/domain/use_cases/location/getLocationPermission.dart';

final manualPositionProvider = StateProvider<LocationEntity>((ref) {
  return const LocationEntity();
});

final locationProvider = FutureProvider<LocationEntity>((ref) async {
  final permission = await ref.watch(getLocationPermissionUseCase.future);
  if (permission) {
    return await ref.watch(getLocationUseCase.future);
  } else {
    return ref.watch(manualPositionProvider);
  }
});
