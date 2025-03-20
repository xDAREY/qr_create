import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_create/presentation/widgets/qr_customization.dart';
import 'package:qr_create/presentation/widgets/qr_input_field.dart';
import 'package:qr_create/presentation/widgets/qr_preview.dart';
import 'package:qr_create/presentation/widgets/qr_save_share.dart';
import 'package:qr_create/presentation/widgets/qr_type_selection.dart';
import 'package:qr_create/providers/qr_provider.dart'; 

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrState = ref.watch(qrProvider);
    final qrNotifier = ref.read(qrProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QRTypeSelection(
              onTypeSelected: qrNotifier.selectType,
              selectedType: qrState.selectedType,
            ),
            const SizedBox(height: 16),
            QRInputField(
              qrType: qrState.selectedType,
              onChanged: (value) => qrNotifier.updateInput('Input', value),
            ),
            const SizedBox(height: 16),
            QRPreview(data: qrState.getFormattedQRData()), 
            const SizedBox(height: 16),
            QRCustomization(
              onColorSelected: qrNotifier.updateColor,
              onAddLogo: () {
                // TODO: Implement logo addition
              },
            ),
            const SizedBox(height: 16),
            QRSaveShare(
              onSave: () => qrNotifier.saveQR(context),
              onShare: () => qrNotifier.shareQR(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) {
          // TODO: Handle navigation
        },
      ),
    );
  }
}
