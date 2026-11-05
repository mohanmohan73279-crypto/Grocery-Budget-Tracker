# Team 4 — Grocery Budget Tracker (GreenBasket)

A Flutter app for tracking household grocery purchases, unit quantities and monthly grocery spending.

## Features
- Add grocery item, quantity, unit, price per unit, category, date, shop and optional note
- Automatically calculate purchase total (quantity × unit price)
- Grocery history with detail and delete actions
- Monthly and all-time spending totals
- Demo monthly budget of ₹8,000 and remaining budget indicator
- Category-wise spending summary
- Local persistence using SharedPreferences
- Provider (`ChangeNotifier`) shared state
- Loading, error/retry and empty states

## Project structure
```text
lib/
  main.dart
  models/grocery_item.dart
  providers/grocery_provider.dart
  services/grocery_storage_service.dart
  screens/
    dashboard_screen.dart
    add_grocery_screen.dart
    grocery_detail_screen.dart
    budget_summary_screen.dart
  widgets/grocery_tile.dart
test/widget_test.dart
```

## Requirements and run
Flutter stable 3.35+, Dart null safety, Android Studio, Android SDK and JDK 17.
```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Data source
Grocery purchases are entered by the user and stored locally with SharedPreferences. No external API is used.

## Team responsibilities
Add all three team members, GitHub usernames and assigned screen/feature before final submission.

## Verification status
This is an initial source package. It has not yet been built or tested on a physical Android device in the target team's environment. Run the commands above, fix reported issues and record actual results before calling it verified.

## Before submission
Add three genuine screenshots, team responsibilities, a defect log, a release APK and evidence of physical-device testing. Every member should contribute and be able to explain their work.
