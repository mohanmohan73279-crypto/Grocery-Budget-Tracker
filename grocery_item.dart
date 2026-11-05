class GroceryItem {
  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.category,
    required this.date,
    this.shop = '',
    this.note = '',
  });

  final String id;
  final String name;
  final double quantity;
  final String unit;
  final double price;
  final String category;
  final DateTime date;
  final String shop;
  final String note;

  double get totalCost => quantity * price;

  Map<String, dynamic> toJson() => {
    'id': id, 'name': name, 'quantity': quantity, 'unit': unit,
    'price': price, 'category': category, 'date': date.toIso8601String(),
    'shop': shop, 'note': note,
  };

  factory GroceryItem.fromJson(Map<String, dynamic> json) => GroceryItem(
    id: json['id'] as String,
    name: json['name'] as String,
    quantity: (json['quantity'] as num).toDouble(),
    unit: json['unit'] as String,
    price: (json['price'] as num).toDouble(),
    category: json['category'] as String,
    date: DateTime.parse(json['date'] as String),
    shop: (json['shop'] as String?) ?? '',
    note: (json['note'] as String?) ?? '',
  );
}
