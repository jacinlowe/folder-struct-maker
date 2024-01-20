import 'package:Folder_Struct_Maker/screens/CenterMenu/options_field/options_field.dart';
import 'package:Folder_Struct_Maker/screens/CenterMenu/parameter_field/parameter_field.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../../../generated/screens/CenterMenu/providers/option_toggle_provider.g.dart';

@riverpod
class OptionToggle extends _$OptionToggle {
  @override
  bool build() {
    return true;
  }

  void toggleOption() {
    state = !state;
    ref.notifyListeners();
  }
}

class CenterMenuWidget extends HookConsumerWidget {
  const CenterMenuWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool optionsOn = ref.watch(optionToggleProvider);
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 500),
      transitionBuilder: (child, animation) =>
          ScaleTransition(scale: animation, child: child),
      child: optionsOn ? ParameterField() : OptionsParamField(),
    );
  }
}
