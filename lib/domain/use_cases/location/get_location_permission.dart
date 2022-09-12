import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/repositories/location_repository.dart';

final getLocationPermissionUseCase = FutureProvider<bool>((ref) async {
  final repository = ref.watch(locationRepository);
  return await repository.isPermitted();
});
