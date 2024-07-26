import 'dart:convert';

class ExpenseInfo {
  String name;
  String category;
  int price;
  String description;

  ExpenseInfo({
    required this.name,
    required this.category,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'description': description,
    };
  }

  static ExpenseInfo fromMap(Map<String, dynamic> map) {
    return ExpenseInfo(
      name: map['name'],
      category: map['category'],
      price: map['price'],
      description: map['description'],
    );
  }

  String toJSON() {
    return jsonEncode(toMap());
  }

  static ExpenseInfo fromJSON(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return ExpenseInfo.fromMap(map);
  }
}
