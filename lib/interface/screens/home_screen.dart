import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nighsky/data/data_bases/constelations_data_source.dart';
import 'package:nighsky/domain/use_cases/location/getLocationPermission.dart';
import 'package:nighsky/interface/controllers/constelattion_controller.dart';
import 'package:nighsky/interface/controllers/date_controller.dart';
import 'package:nighsky/interface/controllers/location_controller.dart';
import 'package:nighsky/interface/controllers/moon_controller.dart';
import 'package:nighsky/interface/hooks/fixed_extend_scroll_controller_hook.dart';

class HomeScreen extends StatefulHookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final TransformationController constellationController;
  double size = 0;

  @override
  void initState() {
    super.initState();
    ref.read(constellationImageProvider.notifier).update();
    constellationController = TransformationController();
  }

  startZoom() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      constellationController.value.setEntry(0, 0, 2);
      constellationController.value.setEntry(1, 1, 2);
      constellationController.value.setEntry(2, 2, 2);
      constellationController.value.setEntry(1, 3, -size / 3);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locationPermitted = ref.watch(getLocationPermissionUseCase);
    final constellationState = ref.watch(constellationImageProvider);
    final moonPhaseIamge = ref.watch(moonImageProvider);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: constellationState.loading
                  ? const CircularProgressIndicator()
                  : Column(
                      children: [
                        Expanded(
                          child: LayoutBuilder(builder: (context, constraints) {
                            if (size != constraints.maxHeight) {
                              size = constraints.maxHeight;
                              startZoom();
                            }
                            size = constraints.maxHeight;
                            return InteractiveViewer(
                              minScale: 1,
                              constrained: true,
                              boundaryMargin: const EdgeInsets.all(0),
                              maxScale: 20,
                              transformationController: constellationController,
                              child: Image.network(
                                constellationState.image!,
                                height: constraints.maxHeight,
                              ),
                            );
                          }),
                        ),
                        moonPhaseIamge.when(
                          data: (moon) => Image.network(
                            moon,
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                          ),
                          error: (error, statck) => Text(error.toString()),
                          loading: () => const CircularProgressIndicator(),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: locationPermitted.whenOrNull(
        data: (data) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SelectionBar(),
            if (!data)
              ManualLocationImput(
                onLatitudeChange: (latitude) {
                  final currentState = ref.watch(manualPositionProvider);
                  ref.read(manualPositionProvider.notifier).state =
                      currentState.copyWith(
                    latitude: latitude,
                  );
                },
                onLongitudeChange: (longitude) {
                  final currentState = ref.watch(manualPositionProvider);
                  ref.read(manualPositionProvider.notifier).state =
                      currentState.copyWith(
                    longitude: longitude,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class SelectionBar extends HookConsumerWidget {
  const SelectionBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 65,
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        boxShadow: kElevationToShadow[3],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          TextButton(
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: ref.watch(dateProvider),
                firstDate:
                    DateTime.now().subtract(const Duration(days: 365 * 50)),
                lastDate: DateTime.now().add(const Duration(days: 365 * 50)),
              );
              if (date != null) {
                ref.read(dateProvider.notifier).state = date;
              }
              ref.read(constellationImageProvider.notifier).update();
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Data da observação'),
                Text(
                  DateFormat('dd/MM/yyyy').format(
                    ref.watch(dateProvider),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.grey.shade900,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(26),
                  ),
                ),
                context: context,
                builder: (context) {
                  return const ConstellationPicker();
                },
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Constelação'),
                Text(
                  ref.watch(selectedConstellationProvider).name,
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class ConstellationPicker extends HookConsumerWidget {
  const ConstellationPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    var constellation = ref.watch(selectedConstellationProvider);
    final controller = useFixedExtendScrollController(
      initialItem: ref.watch(seletedConstellationIndexProvider),
    );
    final constellations = ref.watch(constellationsProvider);
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Escolha a constelação'),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CupertinoPicker.builder(
                itemExtent: 45,
                childCount: constellations.length,
                scrollController: controller,
                diameterRatio: 1.5,
                offAxisFraction: 0,
                onSelectedItemChanged: (value) {
                  final selected = constellations[value];
                  constellation = selected;
                },
                itemBuilder: ((context, index) {
                  final constellation = constellations[index];
                  return Text(constellation.name);
                }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                ref.read(selectedConstellationProvider.notifier).state =
                    constellation;
                ref.read(constellationImageProvider.notifier).update();
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class ManualLocationImput extends StatelessWidget {
  const ManualLocationImput({
    Key? key,
    required this.onLatitudeChange,
    required this.onLongitudeChange,
  }) : super(key: key);

  final void Function(double latitude) onLatitudeChange;
  final void Function(double longitude) onLongitudeChange;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    onLatitudeChange(double.tryParse(text) ?? 0);
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
                    onLongitudeChange(double.tryParse(text) ?? 0);
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
