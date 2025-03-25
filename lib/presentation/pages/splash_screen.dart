import 'package:flutter/material.dart';
import 'dart:async';
import 'package:qr_create/service/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await PermissionService.requestStoragePermissions(context);

    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800080),
      body: Center(
        child: Image.asset("assets/image/splash_screen.png", width: 200),
      ),
    );
  }
}
