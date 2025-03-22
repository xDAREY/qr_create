import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_create/presentation/pages/qr_code_history_screen.dart';
import 'package:qr_create/presentation/pages/settings_screen.dart';
import 'package:qr_create/presentation/widgets/qr_customization.dart';
import 'package:qr_create/presentation/widgets/qr_input_field.dart';
import 'package:qr_create/presentation/widgets/qr_preview.dart';
import 'package:qr_create/presentation/widgets/qr_save_share.dart';
import 'package:qr_create/presentation/widgets/qr_type_selection.dart';
import 'package:qr_create/providers/qr_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const QRGeneratorScreen(), 
    const QRCodeHistoryScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}

class QRGeneratorScreen extends ConsumerWidget {
  const QRGeneratorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrState = ref.watch(qrProvider);
    final qrNotifier = ref.read(qrProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Create'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}