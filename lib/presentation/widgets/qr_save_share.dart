import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_create/presentation/pages/settings_screen.dart';

class QRSaveShare extends ConsumerWidget {
  final VoidCallback onSave;
  final VoidCallback onShare;

  const QRSaveShare({super.key, required this.onSave, required this.onShare});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonColor = ref.watch(themeColorProvider);

    return Column(
      children: [
        // Save QR Code Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.download, color: Colors.white),
            label: const Text('Save QR Code', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        ),
        const SizedBox(height: 8),
        // Share QR Code Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onShare,
            icon: const Icon(Icons.share, color: Colors.white),
            label: const Text('Share QR Code', style: TextStyle(color: Colors.white)),
            style: OutlinedButton.styleFrom(
              backgroundColor: buttonColor, 
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        )
      ],
    );
  }
}