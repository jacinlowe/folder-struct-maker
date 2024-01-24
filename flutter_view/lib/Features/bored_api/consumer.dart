import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../constants.dart';
import '../../utils/format_currency.dart';
import 'provider.dart';
import 'bored_model.dart';

class ActivityWidget extends HookConsumerWidget {
  const ActivityWidget({super.key});
  Widget _handleError(error) {
    print(error);
    return const Text(
        'Oops, Something unexpected happened! Cannot get new activity!');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activity = ref.watch(activityProvider);

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => ref.invalidate(activityProvider),
        child: Container(
          height: 150,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Center(
              child: switch (activity) {
                AsyncData(:final value) => Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Activity:'),
                      Text(value.activity),
                      Text('Up to ${value.participants} can play with you'),
                      Text('Cost: ${formatCurrency(value.price)}')
                    ],
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 500))
                      .slideY(
                          begin: 2,
                          delay: const Duration(milliseconds: 100),
                          duration: const Duration(milliseconds: 600),
                          curve: Easing.emphasizedDecelerate),
                AsyncError(:final error) => _handleError(error),
                _ => const CircularProgressIndicator(),
              },
            ),
          ),
        ),
      ),
    );
  }
}
