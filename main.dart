import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/grocery_provider.dart';
import 'screens/dashboard_screen.dart';
import 'services/grocery_storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider(
    create: (_) => GroceryProvider(GroceryStorageService())..loadItems(),
    child: const GroceryBudgetApp(),
  ));
}

class GroceryBudgetApp extends StatelessWidget {
  const GroceryBudgetApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Grocery Budget',
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF56833B)),
      scaffoldBackgroundColor: const Color(0xFFF6F8F3),
      appBarTheme: const AppBarTheme(centerTitle: false),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
      ),
    ),
    home: const DashboardScreen(),
  );
}
