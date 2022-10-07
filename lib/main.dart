import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/style/default_color_scheme.dart';
import 'module/home/view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return GetMaterialApp(
            title: '😡保持专注！',
            theme: ThemeData(useMaterial3: true, colorScheme: lightDynamic ?? lightColorScheme),
            darkTheme: ThemeData(useMaterial3: true, colorScheme: darkDynamic ?? darkColorScheme),
            home: HomePage(),
          );
        }
    );
  }
}
