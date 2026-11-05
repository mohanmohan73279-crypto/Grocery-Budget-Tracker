import 'package:flutter/material.dart';
import '../models/grocery_item.dart';

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.item, required this.onTap});
  final GroceryItem item;
  final VoidCallback onTap;

  IconData get icon {
    switch (item.category) {
      case 'Fruits & Vegetables': return Icons.eco;
      case 'Dairy': return Icons.egg_alt;
      case 'Snacks': return Icons.cookie;
      case 'Household': return Icons.cleaning_services;
      case 'Staples': return Icons.rice_bowl;
      default: return Icons.shopping_basket;
    }
  }

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 10),
    child: ListTile(
      onTap: onTap,
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text('${item.quantity} ${item.unit} • ${item.category}'),
      trailing: Text('₹${item.totalCost.toStringAsFixed(2)}',
        style: const TextStyle(fontWeight: FontWeight.bold)),
    ),
  );
}
