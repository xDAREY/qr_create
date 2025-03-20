import 'package:flutter/material.dart';

class QRInputField extends StatelessWidget {
  final String qrType;
  final Function(String) onChanged;

  const QRInputField({
    super.key,
    required this.qrType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    switch (qrType) {
      case 'WiFi':
        return Column(
          children: [
            _buildTextField('SSID', onChanged),
            const SizedBox(height: 8),
            _buildTextField('Password', onChanged, obscureText: true),
            const SizedBox(height: 8),
            _buildDropdown(['WPA', 'WEP', 'None'], 'Security Type', onChanged),
          ],
        );
      case 'Email':
        return Column(
          children: [
            _buildTextField('To', onChanged),
            const SizedBox(height: 8),
            _buildTextField('Subject', onChanged),
            const SizedBox(height: 8),
            _buildTextField('Body', onChanged, maxLines: 3),
          ],
        );
      case 'vCard':
        return Column(
          children: [
            _buildTextField('Full Name', onChanged),
            const SizedBox(height: 8),
            _buildTextField('Phone Number', onChanged),
            const SizedBox(height: 8),
            _buildTextField('Email', onChanged),
          ],
        );
      default:
        return _buildTextField('Enter $qrType', onChanged);
    }
  }

  Widget _buildTextField(String hint, Function(String) onChanged, {bool obscureText = false, int maxLines = 1}) {
    return TextField(
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildDropdown(List<String> options, String hint, Function(String) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0))),
      hint: Text(hint),
      items: options.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
      onChanged: (value) => onChanged(value ?? ''),
    );
  }
}