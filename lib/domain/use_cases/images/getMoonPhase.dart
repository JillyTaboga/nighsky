import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/entities/location_entity.dart';
import 'package:nighsky/domain/repositories/images_repository.dart';

final getMoonPhaseUseCase = FutureProvider.family<String, GetMoonphaseArgs>((
  ref,
  args,
) async {
  return await ref.watch(imageRepository).getMoonPhase(
        date: args.date,
        location: args.location,
      );
});

class GetMoonphaseArgs {
  final DateTime date;
  final LocationEntity location;
  GetMoonphaseArgs({
    required this.date,
    required this.location,
  });
}
