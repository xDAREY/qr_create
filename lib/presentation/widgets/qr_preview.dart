import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_create/providers/qr_provider.dart';
import 'package:screenshot/screenshot.dart';

class QRPreview extends ConsumerWidget {
  final String data;
  const QRPreview({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrState = ref.watch(qrProvider);

    return Screenshot(
      controller: qrState.screenshotController,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
        child: QrImageView(
          data: data,
          version: QrVersions.auto,
          size: 200,
          // ignore: deprecated_member_use
          foregroundColor: qrState.qrColor,
        ),
      ),
    );
  }
}
