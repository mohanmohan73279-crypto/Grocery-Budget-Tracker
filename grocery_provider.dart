import 'package:flutter/foundation.dart';
import '../models/grocery_item.dart';
import '../services/grocery_storage_service.dart';

class GroceryProvider extends ChangeNotifier {
  GroceryProvider(this._storage);
  final GroceryStorageService _storage;
  final List<GroceryItem> _items = [];
  bool isLoading = false;
  String? errorMessage;

  List<GroceryItem> get items => List.unmodifiable(_items);
  double get totalSpent => _items.fold(0, (sum, item) => sum + item.totalCost);
  double get currentMonthSpent {
    final now = DateTime.now();
    return _items.where((item) =>
      item.date.year == now.year && item.date.month == now.month)
      .fold(0, (sum, item) => sum + item.totalCost);
  }
  double get monthlyBudgetRemaining => 8000.0 - currentMonthSpent;

  Future<void> loadItems() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();
    try {
      final saved = await _storage.load();
      _items..clear()..addAll(saved);
    } catch (_) {
      errorMessage = 'Could not load grocery records. Please retry.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(GroceryItem item) async {
    _items.insert(0, item);
    notifyListeners();
    try {
      await _storage.save(_items);
    } catch (_) {
      _items.removeWhere((entry) => entry.id == item.id);
      errorMessage = 'Could not save this grocery record.';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteItem(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index < 0) return;
    final removed = _items.removeAt(index);
    notifyListeners();
    try {
      await _storage.save(_items);
    } catch (_) {
      _items.insert(index, removed);
      errorMessage = 'Delete failed. Record restored.';
      notifyListeners();
      rethrow;
    }
  }

  double categoryTotal(String category) => _items
    .where((item) => item.category == category)
    .fold(0, (sum, item) => sum + item.totalCost);
}
