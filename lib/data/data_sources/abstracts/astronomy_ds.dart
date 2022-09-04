import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/data/data_bases/constelations_data_source.dart';
import 'package:nighsky/data/data_sources/implemented/astronomy_data_source._imp.dart';
import 'package:nighsky/domain/entities/constellation_entity.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

final astronomyDS = Provider<AstronomyDS>((ref) {
  final constellations = ref.watch(constellationsProvider);
  return AstronomyDataSource(constellations);
});

abstract class AstronomyDS {
  Future<String> getStarChart({
    required LocationEntity location,
    required DateTime date,
    ConstellationEntity? constellation,
  });

  Future<String> getMoonPhase({
    required LocationEntity location,
    required DateTime date,
  });
}
