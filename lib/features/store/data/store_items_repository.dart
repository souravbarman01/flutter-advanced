import '../domain/models/store_item_model.dart';

class StoreItemsRepository {
  final List<StoreItemModel> _items = <StoreItemModel>[
    const StoreItemModel(
      id: '1',
      name: 'Classic Burger',
      description: 'Grilled beef patty with lettuce, tomato, and house sauce.',
      category: 'Burgers',
      price: 8.99,
      discount: 0,
      stock: 24,
      preparationTimeMinutes: 15,
      calories: 540,
      isVeg: false,
      isSpicy: false,
      ingredients: <String>['Beef patty', 'Lettuce', 'Tomato', 'Burger bun'],
      allergens: <String>['Gluten', 'Dairy'],
    ),
    const StoreItemModel(
      id: '2',
      name: 'Margherita Pizza',
      description: 'Thin crust pizza with mozzarella, basil, and tomato sauce.',
      category: 'Pizza',
      price: 12.50,
      discount: 1.50,
      stock: 10,
      preparationTimeMinutes: 20,
      calories: 720,
      isVeg: true,
      isSpicy: false,
      ingredients: <String>['Mozzarella', 'Tomato sauce', 'Basil'],
      allergens: <String>['Gluten', 'Dairy'],
    ),
    const StoreItemModel(
      id: '3',
      name: 'Spicy Chicken Wrap',
      description: 'Tender chicken strips, crunchy slaw, and chili mayo.',
      category: 'Wraps',
      price: 7.25,
      discount: 0,
      stock: 18,
      preparationTimeMinutes: 12,
      calories: 460,
      isVeg: false,
      isSpicy: true,
      ingredients: <String>['Chicken', 'Tortilla', 'Slaw', 'Chili mayo'],
      allergens: <String>['Gluten', 'Egg'],
    ),
  ];

  static const List<String> baseCategories = <String>[
    'Burgers',
    'Pizza',
    'Wraps',
    'Desserts',
    'Beverages',
    'Salads',
  ];

  List<StoreItemModel> getItems() => List<StoreItemModel>.unmodifiable(_items);

  List<String> getCategories() {
    final Set<String> categories = <String>{...baseCategories};
    for (final StoreItemModel item in _items) {
      categories.add(item.category);
    }
    return <String>['All', ...categories];
  }

  StoreItemModel? getItemById(String id) {
    for (final StoreItemModel item in _items) {
      if (item.id == id) {
        return item;
      }
    }
    return null;
  }

  void addItem(StoreItemModel item) {
    _items.insert(0, item);
  }

  void updateItem(StoreItemModel updatedItem) {
    final int index = _items.indexWhere((item) => item.id == updatedItem.id);
    if (index == -1) {
      return;
    }
    _items[index] = updatedItem;
  }
}
