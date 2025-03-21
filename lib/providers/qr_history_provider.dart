import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final qrHistoryProvider = FutureProvider<List<String>>((ref) async {
  final box = await Hive.openBox<List<String>>('qr_history');
  return box.get('saved_qr_codes', defaultValue: [])!;
});
