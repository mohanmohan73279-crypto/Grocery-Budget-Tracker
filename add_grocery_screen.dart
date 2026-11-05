import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/grocery_item.dart';
import '../providers/grocery_provider.dart';

class AddGroceryScreen extends StatefulWidget {
  const AddGroceryScreen({super.key});
  @override
  State<AddGroceryScreen> createState() => _AddGroceryScreenState();
}

class _AddGroceryScreenState extends State<AddGroceryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _price = TextEditingController();
  final _shop = TextEditingController();
  final _note = TextEditingController();
  String _category = 'Fruits & Vegetables';
  String _unit = 'kg';
  DateTime _date = DateTime.now();
  bool _saving = false;

  @override
  void dispose() {
    _name.dispose(); _quantity.dispose(); _price.dispose();
    _shop.dispose(); _note.dispose();
    super.dispose();
  }

  String? _positive(String? value, String label) {
    final number = double.tryParse((value ?? '').trim());
    if (number == null || number <= 0) return 'Enter a valid $label';
    return null;
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(context: context, initialDate: _date,
      firstDate: DateTime(2020), lastDate: DateTime.now());
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final item = GroceryItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _name.text.trim(),
      quantity: double.parse(_quantity.text.trim()),
      unit: _unit,
      price: double.parse(_price.text.trim()),
      category: _category,
      date: _date,
      shop: _shop.text.trim(),
      note: _note.text.trim(),
    );
    try {
      await context.read<GroceryProvider>().addItem(item);
      if (mounted) Navigator.pop(context);
    } catch (_) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to save purchase. Try again.')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Add grocery purchase')),
    body: Form(key: _formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
      TextFormField(controller: _name, maxLength: 50,
        decoration: const InputDecoration(labelText: 'Item name'),
        validator: (v) => v == null || v.trim().isEmpty ? 'Enter item name' : null),
      const SizedBox(height: 12),
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(child: TextFormField(controller: _quantity,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(labelText: 'Quantity'),
          validator: (v) => _positive(v, 'quantity'))),
        const SizedBox(width: 12),
        SizedBox(width: 112, child: DropdownButtonFormField<String>(
          value: _unit, decoration: const InputDecoration(labelText: 'Unit'),
          items: const ['kg', 'g', 'L', 'ml', 'pack', 'piece']
            .map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
          onChanged: (v) => setState(() => _unit = v ?? 'kg'))),
      ]),
      const SizedBox(height: 12),
      TextFormField(controller: _price,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(labelText: 'Price per unit (₹)'),
        validator: (v) => _positive(v, 'price')),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(value: _category,
        decoration: const InputDecoration(labelText: 'Category'),
        items: const ['Fruits & Vegetables', 'Dairy', 'Snacks', 'Household', 'Staples', 'Other']
          .map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
        onChanged: (v) => setState(() => _category = v ?? 'Other')),
      const SizedBox(height: 12),
      TextFormField(controller: _shop,
        decoration: const InputDecoration(labelText: 'Shop / store (optional)')),
      const SizedBox(height: 12),
      OutlinedButton.icon(onPressed: _pickDate, icon: const Icon(Icons.calendar_month),
        label: Text('Date: ${_date.day}/${_date.month}/${_date.year}')),
      const SizedBox(height: 12),
      TextFormField(controller: _note, maxLines: 2, maxLength: 120,
        decoration: const InputDecoration(labelText: 'Note (optional)')),
      const SizedBox(height: 24),
      FilledButton(onPressed: _saving ? null : _save,
        child: Text(_saving ? 'Saving...' : 'Save purchase')),
    ])),
  );
}
