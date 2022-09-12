import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/entities/location_entity.dart';
import 'package:nighsky/domain/repositories/location_repository.dart';

final getLocationUseCase = FutureProvider<LocationEntity>((ref) async {
  return await ref.watch(locationRepository).getLocation();
});
