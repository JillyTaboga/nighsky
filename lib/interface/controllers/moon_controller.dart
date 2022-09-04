import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/use_cases/images/getMoonPhase.dart';
import 'package:nighsky/interface/controllers/date_controller.dart';
import 'package:nighsky/interface/controllers/location_controller.dart';

final moonImageProvider = FutureProvider<String>((ref) async {
  final location = await ref.watch(locationProvider.future);
  final date = ref.watch(dateProvider);
  final result = await ref.read(
    getMoonPhaseUseCase(
      GetMoonphaseArgs(date: date, location: location),
    ).future,
  );
  return result;
});
