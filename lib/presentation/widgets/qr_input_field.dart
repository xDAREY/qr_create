import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_create/presentation/pages/settings_screen.dart';

class QRInputField extends ConsumerWidget {
  final String qrType;
  final Function(String) onChanged;

  const QRInputField({
    super.key,
    required this.qrType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeColor = ref.watch(themeColorProvider);

    switch (qrType) {
      case 'WiFi':
        return Column(
          children: [
            _buildTextField('SSID', onChanged, themeColor),
            const SizedBox(height: 8),
            _buildTextField('Password', onChanged, themeColor, obscureText: true),
            const SizedBox(height: 8),
            _buildDropdown(['WPA', 'WEP', 'None'], 'Security Type', onChanged, themeColor),
          ],
        );
      case 'Email':
        return Column(
          children: [
            _buildTextField('To', onChanged, themeColor),
            const SizedBox(height: 8),
            _buildTextField('Subject', onChanged, themeColor),
            const SizedBox(height: 8),
            _buildTextField('Body', onChanged, themeColor, maxLines: 3),
          ],
        );
      case 'vCard':
        return Column(
          children: [
            _buildTextField('Full Name', onChanged, themeColor),
            const SizedBox(height: 8),
            _buildTextField('Phone Number', onChanged, themeColor),
            const SizedBox(height: 8),
            _buildTextField('Email', onChanged, themeColor),
          ],
        );
      default:
        return _buildTextField('Enter $qrType', onChanged, themeColor);
    }
  }

  Widget _buildTextField(String hint, Function(String) onChanged, Color themeColor, {bool obscureText = false, int maxLines = 1}) {
    return TextField(
      obscureText: obscureText,
      maxLines: maxLines,
      cursorColor: themeColor,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: themeColor),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: themeColor, width: 2.0),
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown(List<String> options, String hint, Function(String) onChanged, Color themeColor) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: themeColor, width: 2.0),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: themeColor),
      ),
      dropdownColor: Colors.white,
      style: TextStyle(
        color: themeColor,
        fontWeight: FontWeight.w500,
      ),
      icon: Icon(Icons.arrow_drop_down, color: themeColor),
      items: options.map((opt) => DropdownMenuItem(
        value: opt,
        child: Text(opt, style: TextStyle(color: themeColor)),
      )).toList(),
      onChanged: (value) => onChanged(value ?? ''),
    );
  }
}