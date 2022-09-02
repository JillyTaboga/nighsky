import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/entities/location_entity.dart';
import 'package:nighsky/domain/repositories/location_repository.dart';

final manualPositionProvider = StateProvider<LocationEntity>((ref) {
  return const LocationEntity();
});

final locationProvider =
    FutureProvider.autoDispose<LocationEntity>((ref) async {
  final permission = await ref.watch(getLocationPermission.future);
  if (permission) {
    return await ref.watch(getLocation.future);
  } else {
    return ref.watch(manualPositionProvider);
  }
});
