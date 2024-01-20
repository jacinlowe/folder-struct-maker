import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OptionsParamField extends StatefulHookConsumerWidget {
  const OptionsParamField({super.key});

  @override
  ConsumerState<OptionsParamField> createState() => _OptionsParamFieldState();
}

class _OptionsParamFieldState extends ConsumerState<OptionsParamField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Container(
        color: Colors.blue,
      ),
    );
  }
}
