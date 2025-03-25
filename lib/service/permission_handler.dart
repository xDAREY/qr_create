import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStoragePermissions(BuildContext context) async {
    final status = await Permission.storage.request();
    
    if (status != PermissionStatus.granted) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Storage Permission'),
          content: const Text('This app needs storage access to save and share QR codes. Please grant storage permissions in app settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }

  static Future<bool> requestMediaPermissions(BuildContext context) async {
    final imageStatus = await Permission.photos.request();
    final storageStatus = await Permission.storage.request();
    
    if (imageStatus != PermissionStatus.granted || 
        storageStatus != PermissionStatus.granted) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Media Permissions'),
          content: const Text('This app needs media access to save and share QR codes. Please grant permissions in app settings.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      return false;
    }
    return true;
  }
}