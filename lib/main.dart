import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_create/presentation/pages/history_screen.dart';
import 'package:qr_create/presentation/pages/settings_screen.dart';
import 'package:qr_create/presentation/pages/splash_screen.dart';
import 'package:qr_create/presentation/pages/home_screen.dart';
import 'package:qr_create/config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final themeColor = ref.watch(themeColorProvider);
    
    final lightTheme = AppThemes.lightTheme.copyWith(
      primaryColor: themeColor,
      colorScheme: AppThemes.lightTheme.colorScheme.copyWith(
        primary: themeColor,
      ),
      appBarTheme: AppThemes.lightTheme.appBarTheme.copyWith(
        backgroundColor: themeColor,
      ),
    );
    
    final darkTheme = AppThemes.darkTheme.copyWith(
      primaryColor: themeColor,
      colorScheme: AppThemes.darkTheme.colorScheme.copyWith(
        primary: themeColor,
      ),
      appBarTheme: AppThemes.darkTheme.appBarTheme.copyWith(
        backgroundColor: themeColor,
      ),
    );
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Create',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/history': (context) => const QRCodeHistoryScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}