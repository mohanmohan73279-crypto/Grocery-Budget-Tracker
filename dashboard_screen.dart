import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/grocery_provider.dart';
import '../widgets/grocery_tile.dart';
import 'add_grocery_screen.dart';
import 'grocery_detail_screen.dart';
import 'budget_summary_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<GroceryProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('GreenBasket'), actions: [
        IconButton(tooltip: 'Budget summary',
          onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => const BudgetSummaryScreen())),
          icon: const Icon(Icons.analytics_outlined)),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => const AddGroceryScreen())),
        icon: const Icon(Icons.add_shopping_cart), label: const Text('Add purchase')),
      body: RefreshIndicator(
        onRefresh: store.loadItems,
        child: ListView(padding: const EdgeInsets.all(16), children: [
          Card(color: Theme.of(context).colorScheme.primary, child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('MONTHLY GROCERY BUDGET',
                style: TextStyle(color: Colors.white70, letterSpacing: 1)),
              const SizedBox(height: 8),
              Text('₹${store.monthlyBudgetRemaining.toStringAsFixed(0)} left',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
              Text('₹${store.currentMonthSpent.toStringAsFixed(0)} spent of ₹8000',
                style: const TextStyle(color: Colors.white)),
              const SizedBox(height: 12),
              ClipRRect(borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: (store.currentMonthSpent / 8000).clamp(0.0, 1.0),
                  minHeight: 9, backgroundColor: Colors.white30, color: Colors.white)),
            ]),
          )),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Recent purchases', style: Theme.of(context).textTheme.titleLarge),
            Text('All time ₹${store.totalSpent.toStringAsFixed(0)}'),
          ]),
          const SizedBox(height: 12),
          if (store.isLoading)
            const Padding(padding: EdgeInsets.all(32),
              child: Center(child: CircularProgressIndicator()))
          else if (store.errorMessage != null)
            Column(children: [
              Text(store.errorMessage!, textAlign: TextAlign.center),
              TextButton(onPressed: store.loadItems, child: const Text('Retry')),
            ])
          else if (store.items.isEmpty)
            const Padding(padding: EdgeInsets.all(36),
              child: Text('No grocery purchases yet. Add your first item.',
                textAlign: TextAlign.center))
          else
            ...store.items.map((item) => GroceryTile(item: item,
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (_) => GroceryDetailScreen(item: item))))),
          const SizedBox(height: 90),
        ]),
      ),
    );
  }
}
