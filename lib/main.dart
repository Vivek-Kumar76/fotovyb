import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/tokens/tokens.dart';
import 'features/auth/presentation/screens/login_page.dart';
import 'features/onboarding/presentation/screens/registration.dart';
import 'features/home/presentation/screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI status bar to transparent overlay
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const FotoVybApp());
}

class FotoVybApp extends StatelessWidget {
  const FotoVybApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOTOVYB',
      debugShowCheckedModeBanner: false,

      // ── Light Theme
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColors.backgroundLight,
        fontFamily: AppTypography.fontFamilySans,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.accentNavy,
          surface: AppColors.surfaceLight,
          error: AppColors.danger,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimaryLight),
          titleTextStyle: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeLg,
            fontWeight: AppTypography.bold,
            color: AppColors.textPrimaryLight,
          ),
        ),
        dividerColor: AppColors.borderLight,
        splashColor: AppColors.primary.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
      ),

      // ── Dark Theme
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        fontFamily: AppTypography.fontFamilySans,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryDark,
          secondary: AppColors.primaryHover,
          surface: AppColors.surfaceDark,
          error: AppColors.danger,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimaryDark),
          titleTextStyle: TextStyle(
            fontFamily: AppTypography.fontFamilySans,
            fontSize: AppTypography.sizeLg,
            fontWeight: AppTypography.bold,
            color: AppColors.textPrimaryDark,
          ),
        ),
        dividerColor: AppColors.borderDark,
        splashColor: AppColors.primaryDark.withValues(alpha: 0.1),
        highlightColor: Colors.transparent,
      ),

      themeMode: ThemeMode.light,

      // ── Route Table
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}