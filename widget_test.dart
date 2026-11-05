import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:grocery_budget_tracker/providers/grocery_provider.dart';
import 'package:grocery_budget_tracker/screens/dashboard_screen.dart';
import 'package:grocery_budget_tracker/services/grocery_storage_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  testWidgets('shows empty grocery purchases message', (tester) async {
    final provider = GroceryProvider(GroceryStorageService());
    await tester.pumpWidget(ChangeNotifierProvider<GroceryProvider>.value(
      value: provider,
      child: const MaterialApp(home: DashboardScreen()),
    ));
    await tester.pumpAndSettle();
    expect(find.text('No grocery purchases yet. Add your first item.'), findsOneWidget);
  });
}
