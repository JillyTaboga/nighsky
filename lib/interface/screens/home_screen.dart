import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/data/data_sources/astronomy_data_source.dart';
import 'package:nighsky/domain/repositories/location_repository.dart';
import 'package:nighsky/interface/controllers/location_controller.dart';

final moonImageProvider = StateProvider<String>((ref) {
  return '';
});
final skyImageProvider = StateProvider<String>((ref) {
  return '';
});

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);
    final locationPermitted = ref.watch(getLocationPermission);
    final moonImage = ref.watch(moonImageProvider);
    final skyImage = ref.watch(skyImageProvider);
    return Scaffold(
      body: Center(
        child: location.when(
          data: (data) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(data.toString()),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final result = await AstronomyDataSource().getMoonPhase(
                    location: data,
                    date: DateTime.now(),
                  );
                  ref.read(moonImageProvider.notifier).state = result;
                  final resultSky = await AstronomyDataSource().getStarChart(
                    location: data,
                    date: DateTime.now(),
                  );
                  ref.read(skyImageProvider.notifier).state = resultSky;
                },
                child: const Text(
                  'Calcular',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (moonImage.isNotEmpty)
                Image.network(
                  moonImage,
                  fit: BoxFit.fitWidth,
                ),
              if (skyImage.isNotEmpty)
                InteractiveViewer(
                  maxScale: 10,
                  child: Image.network(
                    skyImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
            ],
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: locationPermitted.whenOrNull(
        data: (data) => Opacity(
          opacity: data ? 0 : 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.maxFinite,
            height: 100,
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                    'Não foi possível definir sua localização automaticamente'),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text('Latitude'),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          final currentState =
                              ref.watch(manualPositionProvider);
                          ref.read(manualPositionProvider.notifier).state =
                              currentState.copyWith(
                            latitude: double.tryParse(text) ?? 0,
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          label: Text('Logitude'),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          final currentState =
                              ref.watch(manualPositionProvider);
                          ref.read(manualPositionProvider.notifier).state =
                              currentState.copyWith(
                            longitude: double.tryParse(text) ?? 0,
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
