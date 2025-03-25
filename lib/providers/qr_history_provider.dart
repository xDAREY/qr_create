import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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