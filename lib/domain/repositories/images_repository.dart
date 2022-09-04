import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/data/data_sources/abstracts/astronomy_ds.dart';
import 'package:nighsky/domain/entities/constellation_entity.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

final imageRepository = Provider<ImageRepository>((ref) {
  final dataSource = ref.watch(astronomyDS);
  return ImageRepository(dataSource);
});

class ImageRepository {
  const ImageRepository(this._astronomyDataSource);
  final AstronomyDS _astronomyDataSource;

  Future<String> getMoonPhase({
    required DateTime date,
    required LocationEntity location,
  }) async {
    try {
      return await _astronomyDataSource.getMoonPhase(
        location: location,
        date: date,
      );
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Não foi possível se conectar a internet');
      } else {
        throw Exception(
            'Não foi possível se comunicar ao servidor astronômico');
      }
    }
  }

  Future<String> getConstelattions({
    required DateTime date,
    required LocationEntity location,
    ConstellationEntity? constellation,
  }) async {
    try {
      return await _astronomyDataSource.getStarChart(
        location: location,
        date: date,
        constellation: constellation,
      );
    } catch (e) {
      if (e is SocketException) {
        throw Exception('Não foi possível se conectar a internet');
      } else {
        throw Exception(
            'Não foi possível se comunicar ao servidor astronômico');
      }
    }
  }
}
