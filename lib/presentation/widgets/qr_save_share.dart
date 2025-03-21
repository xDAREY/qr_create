import 'package:flutter/material.dart';

class QRSaveShare extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onShare;

  const QRSaveShare({super.key, required this.onSave, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onSave,
            icon: const Icon(Icons.download, color: Colors.white,),
            label: const Text('Save QR Code'),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onShare,
            icon: const Icon(Icons.share, color: Colors.white,),
            label: const Text('Share QR Code'),
          ),
        ),
      ],
    );
  }
}
