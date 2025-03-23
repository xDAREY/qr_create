import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_create/config/theme.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class QRState {
  final String selectedType;
  final Map<String, String> qrDataMap;
  final Color qrColor;
  final ScreenshotController screenshotController;

  QRState({
    this.selectedType = 'Text',
    Map<String, String>? qrDataMap,
    this.qrColor = Colors.black,
    ScreenshotController? screenshotController,
  })  : qrDataMap = qrDataMap ?? {},
        screenshotController = screenshotController ?? ScreenshotController();

  QRState copyWith({
    String? selectedType,
    Map<String, String>? qrDataMap,
    Color? qrColor,
  }) {
    return QRState(
      selectedType: selectedType ?? this.selectedType,
      qrDataMap: qrDataMap ?? this.qrDataMap,
      qrColor: qrColor ?? this.qrColor,
      screenshotController: screenshotController,
    );
  }

  String getFormattedQRData() {
    switch (selectedType) {
      case 'WiFi':
        return 'WIFI:S:${qrDataMap['SSID'] ?? ''};T:${qrDataMap['Security Type'] ?? 'None'};P:${qrDataMap['Password'] ?? ''};;';
      case 'Email':
        return 'mailto:${qrDataMap['To'] ?? ''}?subject=${qrDataMap['Subject'] ?? ''}&body=${qrDataMap['Body'] ?? ''}';
      case 'vCard':
        return 'BEGIN:VCARD\nFN:${qrDataMap['Full Name'] ?? ''}\nTEL:${qrDataMap['Phone Number'] ?? ''}\nEMAIL:${qrDataMap['Email'] ?? ''}\nEND:VCARD';
      default:
        return qrDataMap['Input'] ?? '';
    }
  }
  
  // Generate a unique identifier based on content
  String generateUniqueId() {
    String data = getFormattedQRData();
    return '${selectedType.toLowerCase()}_${data.hashCode}';
  }
}

class QRNotifier extends StateNotifier<QRState> {
  QRNotifier() : super(QRState());

  void selectType(String type) {
    state = state.copyWith(selectedType: type, qrDataMap: {});
  }

  void updateInput(String field, String value) {
    final updatedData = Map<String, String>.from(state.qrDataMap)..[field] = value;
    state = state.copyWith(qrDataMap: updatedData);
  }

  void updateColor(Color color) {
    state = state.copyWith(qrColor: color);
  }

  Future<void> saveQR(BuildContext context) async {
    try {
      // Generate unique ID for this QR code
      String uniqueId = state.generateUniqueId();
      
      // Capture QR code image
      final Uint8List? image = await state.screenshotController.capture();
      if (image == null) return;
      
      // Save to gallery
      final result = await ImageGallerySaver.saveImage(
        image,
        name: 'QR_${state.selectedType}_${DateTime.now().millisecondsSinceEpoch}',
        quality: 100,
      );
      
      // Get the saved file path
      final String savedPath = result['filePath'] ?? '';
      
      // Save reference to Hive for history
      final box = await Hive.openBox('qr_history');
      List<dynamic> history = box.get('saved_qr_codes', defaultValue: []) as List? ?? [];
      
      // Create the entry map
      final Map<String, dynamic> entry = {
        'id': uniqueId,
        'path': savedPath,
        'type': state.selectedType,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      };
      
      // Check if QR with same content already exists
      bool exists = history.any((item) => (item as Map)['id'] == uniqueId);
      
      if (!exists) {
        history.add(entry);
        await box.put('saved_qr_codes', history);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('QR Code saved to Photos')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving QR Code: $e')),
      );
    }
  }

  Future<void> shareQR(BuildContext context) async {
    try {
      // Create a temporary file for sharing
      final directory = await getTemporaryDirectory();
      final String uniqueId = state.generateUniqueId();
      final filePath = '${directory.path}/qr_${state.selectedType.toLowerCase()}_$uniqueId.png';

      final Uint8List? image = await state.screenshotController.capture();
      if (image == null) return;

      final file = File(filePath);
      await file.writeAsBytes(image);

      // Save to history if not already there
      final box = await Hive.openBox('qr_history');
      List<dynamic> history = box.get('saved_qr_codes', defaultValue: []) as List? ?? [];
      
      // Check if QR with same content already exists
      bool exists = history.any((item) => (item as Map)['id'] == uniqueId);
      
      if (!exists) {
        // Save to gallery for history
        final result = await ImageGallerySaver.saveImage(
          image,
          name: 'QR_${state.selectedType}_${DateTime.now().millisecondsSinceEpoch}',
          quality: 100,
        );
        
        final String savedPath = result['filePath'] ?? '';
        
        // Create the entry map
        final Map<String, dynamic> entry = {
          'id': uniqueId,
          'path': savedPath,
          'type': state.selectedType,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        };
        
        history.add(entry);
        await box.put('saved_qr_codes', history);
      }

      await Share.shareXFiles([XFile(filePath)], text: 'Here is my QR Code!');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing QR Code: $e')),
      );
    }
  }
}

final qrProvider = StateNotifierProvider<QRNotifier, QRState>((ref) => QRNotifier());
final buttonColorProvider = StateProvider<Color>((ref) => AppThemes.primaryPurple);