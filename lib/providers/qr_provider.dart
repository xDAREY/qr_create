import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:hive/hive.dart';

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
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png';

      final image = await state.screenshotController.capture();
      if (image == null) return;

      final file = File(filePath);
      await file.writeAsBytes(image);

      // Save QR data to Hive for history
      final box = await Hive.openBox<List<String>>('qr_history');
      List<String> history = box.get('saved_qr_codes', defaultValue: [])!;
      history.add(filePath);
      await box.put('saved_qr_codes', history);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('QR Code saved to: $filePath')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving QR Code: $e')),
      );
    }
  }

  Future<void> shareQR(BuildContext context) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/qr_code_${DateTime.now().millisecondsSinceEpoch}.png';

      final image = await state.screenshotController.capture();
      if (image == null) return;

      final file = File(filePath);
      await file.writeAsBytes(image);

      await Share.shareXFiles([XFile(filePath)], text: 'Here is my QR Code!');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing QR Code: $e')),
      );
    }
  }
}

final qrProvider = StateNotifierProvider<QRNotifier, QRState>((ref) => QRNotifier());
