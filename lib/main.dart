import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart'; // Import Riverpod
import 'package:qr_create/presentation/pages/splash_screen.dart';
import 'package:qr_create/presentation/pages/home_screen.dart';
import 'package:qr_create/config/theme.dart';

void main() {
  runApp(
    const ProviderScope( 
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Create',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
