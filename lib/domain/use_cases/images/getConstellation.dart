import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nighsky/domain/entities/constellation_entity.dart';
import 'package:nighsky/domain/entities/location_entity.dart';
import 'package:nighsky/domain/repositories/images_repository.dart';

final getConstellationUseCase =
    FutureProvider.family<String, GetConstellationArgs>((
  ref,
  args,
) async {
  return await ref.watch(imageRepository).getConstelattions(
        date: args.date,
        location: args.location,
        constellation: args.constellation,
      );
});

class GetConstellationArgs {
  final DateTime date;
  final LocationEntity location;
  final ConstellationEntity? constellation;
  GetConstellationArgs({
    required this.date,
    required this.location,
    this.constellation,
  });
}
