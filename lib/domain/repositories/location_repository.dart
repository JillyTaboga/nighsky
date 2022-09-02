import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/data/data_sources/location_data_source.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

final getLocation = FutureProvider.autoDispose<LocationEntity>((ref) async {
  final dataSource = ref.watch(locationDataSource);
  return await dataSource.getLocation();
});

final getLocationPermission = FutureProvider.autoDispose<bool>((ref) async {
  final dataSource = ref.watch(locationDataSource);
  final isPermitted = await dataSource.permited();
  return isPermitted;
});
