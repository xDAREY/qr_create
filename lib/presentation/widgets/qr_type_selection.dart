import 'package:flutter/material.dart';
import 'package:qr_create/config/theme.dart';

class QRTypeSelection extends StatelessWidget {
  final Function(String) onTypeSelected;
  final String selectedType;

  const QRTypeSelection({
    super.key,
    required this.onTypeSelected,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    final types = ['Text', 'URL', 'WiFi', 'vCard', 'Email', 'Phone', 'SMS', 'JSON'];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: types.map((type) {
        final isSelected = type == selectedType;
        return ElevatedButton(
          onPressed: () => onTypeSelected(type),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? AppThemes.primaryPurple : Colors.grey.shade300,
            foregroundColor: isSelected ? Colors.white : Colors.black,
          ),
          child: Text(type),
        );
      }).toList(),
    );
  }
}


