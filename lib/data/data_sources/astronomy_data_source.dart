import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:nighsky/data/data_sources/constelations_data_source.dart';
import 'package:nighsky/domain/entities/constellation_entity.dart';
import 'package:nighsky/domain/entities/location_entity.dart';

class AstronomyDataSource {
  static const String _baseUrl = 'https://api.astronomyapi.com/api/v2/studio/';
  static String get _authEnconded => const String.fromEnvironment('ASTROID');

  final Dio _http = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {'Authorization': 'Basic $_authEnconded'},
  ));

  Future<String> getStarChart({
    required LocationEntity location,
    required DateTime date,
    ConstellationEntity? constellation,
  }) async {
    final constellationID = constellation?.cod.toLowerCase() ??
        constellations[Random().nextInt(constellations.length)]
            .cod
            .toLowerCase();
    final data = {
      'observer': _Observer(
        latitude: location.latitude,
        longitude: location.longitude,
        date: date.subtract(const Duration(days: 365 * 10)),
      ).toMap(),
      // "view": {
      //   "type": "area",
      //   "zoom": 1,
      //   "parameters": {
      //     "position": {
      //       "equatorial": {
      //         "rightAscension": 14.83,
      //         "declination": -15.23,
      //       },
      //     },
      //   }
      // }
      "view": {
        "type": "constellation",
        "parameters": {
          "constellation": constellationID // 3 letter constellation id
        }
      }
    };
    final response = await _http.post(
      'star-chart',
      data: data,
    );
    return response.data['data']['imageUrl'];
  }

  Future<String> getMoonPhase({
    required LocationEntity location,
    required DateTime date,
  }) async {
    final data = {
      "format": "png",
      'observer': _Observer(
        latitude: location.latitude,
        longitude: location.longitude,
        date: date,
      ).toMap(),
      "style": {
        "moonStyle": "default",
        "backgroundStyle": "solid",
        "backgroundColor": "black",
        "headingColor": "white",
        "textColor": "white"
      },
      "view": {
        "type": "landscape-simple",
        "orientation": "south-up",
      }
    };
    final response = await _http.post(
      'moon-phase',
      data: data,
    );
    return response.data['data']['imageUrl'];
  }
}

class _Observer {
  final double latitude;
  final double longitude;
  final DateTime date;
  _Observer({
    required this.latitude,
    required this.longitude,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'date': DateFormat('yyyy-MM-dd').format(date),
    };
  }

  String toJson() => json.encode(toMap());
}
