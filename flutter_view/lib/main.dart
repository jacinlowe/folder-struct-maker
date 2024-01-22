import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'Features/attribute_fields/models/attribute_model.dart';
import 'constants.dart';

import 'screens/main_screen.dart';

void main() async {
  //  CAN SET UP A CUSTOM TOP BAR
  // WidgetsFlutterBinding.ensureInitialized();
  // await windowManager.ensureInitialized();
  // await windowManager.waitUntilReadyToShow().then((_) async {
  //   await windowManager.setTitleBarStyle(TitleBarStyle.hidden);
  //   await windowManager.setTitle('No title');
  //   await windowManager.show();
  // });
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    WindowManager.instance.setMinimumSize(const Size(1400, 1020));
  }
  // await initializeHive();
  runApp(const ProviderScope(child: MyApp()));
  getWindowSize();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

void getWindowSize() {
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;
  Size size = view.physicalSize;
  print(size);
}

// Future<void> initializeHive() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(DateFormatsAdapter());
//   Hive.registerAdapter(DateAttributeAdapter());
//   Hive.registerAdapter(NumberAttributeAdapter());
//   Hive.registerAdapter(CustomTextAttributeAdapter());
//   Hive.registerAdapter(DropdownAttributeAdapter());
//   Hive.registerAdapter(UserNameAttributeAdapter());
//   await Hive.openBox<Attribute>('attributes');
// }
