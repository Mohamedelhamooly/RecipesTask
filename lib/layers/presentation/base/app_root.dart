import 'package:flutter/material.dart';
import 'package:posts_task/layers/presentation/pages/home/home_page.dart';

import 'theme.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    const theme = CustomTheme();

    return MaterialApp(
      themeMode: themeMode,
      theme: theme.toThemeData(),
      darkTheme: theme.toThemeDataDark(),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }

  // ---------------------------------------------------------------------------
  // _Helpers
  // ---------------------------------------------------------------------------
  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange({bool? useLightMode = false}) {
    setState(() {
      themeMode = useLightMode! ? ThemeMode.light : ThemeMode.dark;
    });
  }
}
