import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Creates [FixedExtendScrollController] that will be disposed automatically.
///
/// See also:
/// - [FixedExtendScrollController]
FixedExtentScrollController useFixedExtendScrollController({
  required int initialItem,
  List<Object?>? keys,
}) {
  return use(
    _FixedExtendScrollControllerHook(
      initialItem: initialItem,
      keys: keys,
    ),
  );
}

class _FixedExtendScrollControllerHook
    extends Hook<FixedExtentScrollController> {
  const _FixedExtendScrollControllerHook({
    required this.initialItem,
    List<Object?>? keys,
  }) : super(keys: keys);

  final int initialItem;

  @override
  HookState<FixedExtentScrollController, Hook<FixedExtentScrollController>>
      createState() => _FixedExtendScrollControllerHookState();
}

class _FixedExtendScrollControllerHookState extends HookState<
    FixedExtentScrollController, _FixedExtendScrollControllerHook> {
  late final controller = FixedExtentScrollController(
    initialItem: hook.initialItem,
  );

  @override
  FixedExtentScrollController build(BuildContext context) => controller;

  @override
  void dispose() => controller.dispose();

  @override
  String get debugLabel => 'useFixedEntendScrollController';
}
