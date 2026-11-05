import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grocery_provider.dart';

class BudgetSummaryScreen extends StatelessWidget {
  const BudgetSummaryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<GroceryProvider>();
    const categories = ['Fruits & Vegetables', 'Dairy', 'Snacks', 'Household', 'Staples', 'Other'];
    return Scaffold(
      appBar: AppBar(title: const Text('Grocery budget summary')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: ListTile(title: const Text('All-time grocery spending'),
          trailing: Text('₹${store.totalSpent.toStringAsFixed(2)}'))),
        Card(child: ListTile(title: const Text('Current month spending'),
          trailing: Text('₹${store.currentMonthSpent.toStringAsFixed(2)}'))),
        Card(child: ListTile(title: const Text('Monthly budget remaining'),
          subtitle: const Text('Based on demo budget of ₹8,000'),
          trailing: Text('₹${store.monthlyBudgetRemaining.toStringAsFixed(2)}'))),
        const SizedBox(height: 12),
        Text('Category breakdown', style: Theme.of(context).textTheme.titleLarge),
        ...categories.map((category) => Card(child: ListTile(
          title: Text(category),
          trailing: Text('₹${store.categoryTotal(category).toStringAsFixed(2)}')))),
      ]),
    );
  }
}
