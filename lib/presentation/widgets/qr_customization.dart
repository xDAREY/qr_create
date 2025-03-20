import 'package:flutter/material.dart';

class QRCustomization extends StatelessWidget {
  final Function(Color) onColorSelected;
  final VoidCallback onAddLogo;

  const QRCustomization({
    super.key,
    required this.onColorSelected,
    required this.onAddLogo,
  });

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.blue, Colors.red, Colors.green, Colors.orange, Colors.purple];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('QR Code Color:'),
        const SizedBox(height: 8),
        Row(
          children: colors.map((color) {
            return GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black26),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        
      ],
    );
  }
}
