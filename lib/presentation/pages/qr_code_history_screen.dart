import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:qr_create/providers/qr_history_provider.dart';
import 'package:qr_create/providers/qr_provider.dart';

final viewModeProvider = StateProvider<bool>((ref) => true); // true = ListView, false = GridView

class QRCodeHistoryScreen extends ConsumerWidget {
  const QRCodeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(qrHistoryProvider);
    final isListView = ref.watch(viewModeProvider);
    final qrNotifier = ref.read(qrProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR History'),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.grid_view : Icons.list),
            onPressed: () {
              ref.read(viewModeProvider.notifier).state = !isListView; // Toggle view mode
            },
          ),
        ],
      ),
      body: history.when(
        data: (qrList) => qrList.isEmpty
            ? const Center(child: Text('No saved QR codes yet.'))
            : isListView
                ? ListView.builder(
                    itemCount: qrList.length,
                    itemBuilder: (context, index) {
                      final filePath = qrList[index];
                      return Card(
                        child: ListTile(
                          leading: Image.file(File(filePath), width: 50, height: 50),
                          title: Text('QR Code ${index + 1}'),
                          subtitle: Text(filePath),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              final box = await Hive.openBox<List<String>>('qr_history');
                              List<String> updatedHistory = box.get('saved_qr_codes', defaultValue: [])!;
                              updatedHistory.removeAt(index);
                              await box.put('saved_qr_codes', updatedHistory);

                              ref.invalidate(qrHistoryProvider);
                            },
                          ),
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: qrList.length,
                    itemBuilder: (context, index) {
                      final filePath = qrList[index];
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.file(File(filePath), width: 80, height: 80),
                            const SizedBox(height: 8),
                            Text('QR ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share),
                                  onPressed: () {
                                    () => qrNotifier.shareQR(context);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    final box = await Hive.openBox<List<String>>('qr_history');
                                    List<String> updatedHistory = box.get('saved_qr_codes', defaultValue: [])!;
                                    updatedHistory.removeAt(index);
                                    await box.put('saved_qr_codes', updatedHistory);

                                    ref.invalidate(qrHistoryProvider);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
        error: (error, stack) => Center(child: Text('Error: $error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}