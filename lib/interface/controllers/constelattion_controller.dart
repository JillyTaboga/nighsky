import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/data/data_bases/constelations_data_source.dart';
import 'package:nighsky/domain/entities/constellation_entity.dart';
import 'package:nighsky/domain/use_cases/images/getConstellation.dart';
import 'package:nighsky/interface/controllers/date_controller.dart';
import 'package:nighsky/interface/controllers/location_controller.dart';

final selectedConstellationProvider = StateProvider<ConstellationEntity>((ref) {
  final constellations = ref.watch(constellationsProvider);
  return constellations[Random().nextInt(constellations.length)];
});

final seletedConstellationIndexProvider = Provider<int>(
  (ref) {
    final selectedConstellation = ref.watch(selectedConstellationProvider);
    final index =
        ref.watch(constellationsProvider).indexOf(selectedConstellation);
    return index;
  },
);

final _constellationArgsProvider =
    FutureProvider<GetConstellationArgs>((ref) async {
  final location = await ref.watch(locationProvider.future);
  final date = ref.watch(dateProvider);
  final constellation = ref.watch(selectedConstellationProvider);
  return GetConstellationArgs(
    date: date,
    location: location,
    constellation: constellation,
  );
});

final constellationImageProvider =
    StateNotifierProvider<ConstellationNotifier, ConstellationState>((ref) {
  return ConstellationNotifier(ref);
});

class ConstellationNotifier extends StateNotifier<ConstellationState> {
  ConstellationNotifier(
    this.ref,
  ) : super(ConstellationState());

  final Ref ref;

  update() async {
    state = state.copyWith(loading: true);
    final args = await ref.read(_constellationArgsProvider.future);
    final result = await ref.read(getConstellationUseCase(args).future);
    state = state.copyWith(
      loading: false,
      image: result,
    );
  }
}

class ConstellationState {
  final String? image;
  final bool loading;
  ConstellationState({
    this.image,
    this.loading = true,
  });

  ConstellationState copyWith({
    String? image,
    bool? loading,
  }) {
    return ConstellationState(
      image: image ?? this.image,
      loading: loading ?? this.loading,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConstellationState &&
        other.image == image &&
        other.loading == loading;
  }

  @override
  int get hashCode => image.hashCode ^ loading.hashCode;
}
