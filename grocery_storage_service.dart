import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/grocery_item.dart';

class GroceryStorageService {
  static const _key = 'greenbasket_grocery_items';

  Future<List<GroceryItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded.map((item) =>
      GroceryItem.fromJson(item as Map<String, dynamic>)).toList();
  }

  Future<void> save(List<GroceryItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key,
      jsonEncode(items.map((item) => item.toJson()).toList()));
  }
}
