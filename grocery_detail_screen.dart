import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/grocery_item.dart';
import '../providers/grocery_provider.dart';

class GroceryDetailScreen extends StatelessWidget {
  const GroceryDetailScreen({super.key, required this.item});
  final GroceryItem item;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Purchase details')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const CircleAvatar(radius: 34, child: Icon(Icons.shopping_basket, size: 32)),
      const SizedBox(height: 16),
      Text(item.name, textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall),
      Text('₹${item.totalCost.toStringAsFixed(2)}', textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 20),
      _InfoRow('Quantity', '${item.quantity} ${item.unit}'),
      _InfoRow('Price per unit', '₹${item.price.toStringAsFixed(2)}'),
      _InfoRow('Category', item.category),
      _InfoRow('Shop', item.shop.isEmpty ? 'Not provided' : item.shop),
      _InfoRow('Date', '${item.date.day}/${item.date.month}/${item.date.year}'),
      _InfoRow('Note', item.note.isEmpty ? 'No note added' : item.note),
      const SizedBox(height: 20),
      OutlinedButton.icon(onPressed: () async {
        try {
          await context.read<GroceryProvider>().deleteItem(item.id);
          if (context.mounted) Navigator.pop(context);
        } catch (_) {
          if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Delete failed. Try again.')));
        }
      }, icon: const Icon(Icons.delete_outline), label: const Text('Delete purchase')),
    ]),
  );
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(
    title: Text(label), subtitle: SelectableText(value)));
}
