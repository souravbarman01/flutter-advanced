class StoreItemModel {
  final String id;
  final String name;
  final String description;
  final String category;
  final double price;
  final double discount;
  final int stock;
  final int preparationTimeMinutes;
  final int calories;
  final bool isVeg;
  final bool isSpicy;
  final List<String> ingredients;
  final List<String> allergens;

  const StoreItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.discount,
    required this.stock,
    required this.preparationTimeMinutes,
    required this.calories,
    required this.isVeg,
    required this.isSpicy,
    required this.ingredients,
    required this.allergens,
  });

  StoreItemModel copyWith({
    String? id,
    String? name,
    String? description,
    String? category,
    double? price,
    double? discount,
    int? stock,
    int? preparationTimeMinutes,
    int? calories,
    bool? isVeg,
    bool? isSpicy,
    List<String>? ingredients,
    List<String>? allergens,
  }) {
    return StoreItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      stock: stock ?? this.stock,
      preparationTimeMinutes:
          preparationTimeMinutes ?? this.preparationTimeMinutes,
      calories: calories ?? this.calories,
      isVeg: isVeg ?? this.isVeg,
      isSpicy: isSpicy ?? this.isSpicy,
      ingredients: ingredients ?? this.ingredients,
      allergens: allergens ?? this.allergens,
    );
  }
}
