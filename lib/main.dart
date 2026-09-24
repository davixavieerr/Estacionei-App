import 'dart:ui';
import 'package:flutter/material.dart';
import 'core/theme/app_colors.dart';
import 'features/map/presentation/main_shell_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EstacioneiApp());
}

/// Permite arraste suave (drag gestures) tanto no mobile (touch) quanto no PC (mouse e trackpad)
class AppScrollBehavior extends MaterialScrollBehavior {
  const AppScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };
}

class EstacioneiApp extends StatelessWidget {
  const EstacioneiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estacionei',
      debugShowCheckedModeBanner: false,
      scrollBehavior: const AppScrollBehavior(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.darkBackground,
        primaryColor: AppColors.primaryBlue,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.cardSurface,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const MainShellScreen(),
    );
  }
}
