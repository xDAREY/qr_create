import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

final qrHistoryProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  try {
    final box = await Hive.openBox('qr_history');
    final List<dynamic>? rawHistory = box.get('saved_qr_codes') as List?;
    
    if (rawHistory == null || rawHistory.isEmpty) return [];
    
    final List<Map<String, dynamic>> history = 
        rawHistory.map((item) => Map<String, dynamic>.from(item as Map)).toList();
        history.sort((a, b) => (b['timestamp'] ?? 0).compareTo(a['timestamp'] ?? 0));
    
    return history;
  } catch (e) {
    debugPrint('Error opening Hive box: $e');
    return [];
  }
});

final viewModeProvider = StateProvider<bool>((ref) => true); 

class QRCodeHistoryScreen extends ConsumerWidget {
  const QRCodeHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(qrHistoryProvider);
    final isListView = ref.watch(viewModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR History'),
        actions: [
          IconButton(
            icon: Icon(isListView ? Icons.grid_view : Icons.list),
            onPressed: () {
              ref.read(viewModeProvider.notifier).state = !isListView; 
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
                      final item = qrList[index];
                      final String filePath = item['path'] ?? '';
                      final String qrType = item['type'] ?? 'QR';
                      
                      return Card(
                        child: ListTile(
                          leading: filePath.isNotEmpty 
                              ? Image.file(File(filePath), width: 50, height: 50)
                              : const Icon(Icons.qr_code, size: 50),
                          title: Text('$qrType QR Code'),
                          subtitle: Text(
                            DateTime.fromMillisecondsSinceEpoch(
                              item['timestamp'] ?? 0
                            ).toString().substring(0, 16)
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share, color: Colors.blue),
                                onPressed: () {
                                  if (filePath.isNotEmpty) {
                                    Share.shareXFiles([XFile(filePath)], text: 'Here is my QR Code!');
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () async {
                                  final box = await Hive.openBox('qr_history');
                                  List<dynamic> rawHistory = box.get('saved_qr_codes', defaultValue: []) as List;
                                  
                                  rawHistory.removeWhere(
                                    (element) => (element as Map)['id'] == item['id']
                                  );
                                  
                                  await box.put('saved_qr_codes', rawHistory);
                                  ref.invalidate(qrHistoryProvider);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: qrList.length,
                    itemBuilder: (context, index) {
                      final item = qrList[index];
                      final String filePath = item['path'] ?? '';
                      final String qrType = item['type'] ?? 'QR';
                      
                      return Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            filePath.isNotEmpty 
                                ? Image.file(File(filePath), width: 100, height: 100)
                                : const Icon(Icons.qr_code, size: 100),
                            const SizedBox(height: 8),
                            Text('$qrType QR', style: const TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              DateTime.fromMillisecondsSinceEpoch(
                                item['timestamp'] ?? 0
                              ).toString().substring(0, 10),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.share, color: Colors.blue),
                                  onPressed: () {
                                    if (filePath.isNotEmpty) {
                                      Share.shareXFiles([XFile(filePath)], text: 'Here is my QR Code!');
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () async {
                                    final box = await Hive.openBox('qr_history');
                                    List<dynamic> rawHistory = box.get('saved_qr_codes', defaultValue: []) as List;
                                    
                                    rawHistory.removeWhere(
                                      (element) => (element as Map)['id'] == item['id']
                                    );
                                    
                                    await box.put('saved_qr_codes', rawHistory);
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