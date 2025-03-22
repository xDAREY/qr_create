import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_create/presentation/pages/settings_screen.dart';

class QRTypeSelection extends ConsumerWidget {
  final Function(String) onTypeSelected;
  final String selectedType;

  const QRTypeSelection({
    super.key,
    required this.onTypeSelected,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final types = ['Text', 'URL', 'WiFi', 'vCard', 'Email', 'Phone', 'SMS', 'JSON'];
    final themeColor = ref.watch(themeColorProvider);

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: types.map((type) {
        final isSelected = type == selectedType;
        return ElevatedButton(
          onPressed: () => onTypeSelected(type),
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? themeColor : Colors.grey.shade300,
            foregroundColor: isSelected ? Colors.white : Colors.black,
          ),
          child: Text(type),
        );
      }).toList(),
    );
  }
}