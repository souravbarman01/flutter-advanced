import 'package:get/get.dart';

import '../data/store_items_repository.dart';
import '../domain/models/store_item_model.dart';

class StoreItemsController extends GetxController {
  StoreItemsController({required this.repository});

  final StoreItemsRepository repository;

  List<StoreItemModel> _items = <StoreItemModel>[];
  String _selectedCategory = 'All';

  List<StoreItemModel> get items => _items;
  String get selectedCategory => _selectedCategory;
  List<String> get categories => repository.getCategories();

  List<StoreItemModel> get filteredItems {
    if (_selectedCategory == 'All') {
      return _items;
    }
    return _items.where((item) => item.category == _selectedCategory).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  void loadItems() {
    _items = repository.getItems();
    if (!categories.contains(_selectedCategory)) {
      _selectedCategory = 'All';
    }
    update();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    update();
  }

  StoreItemModel? getItemById(String id) {
    for (final StoreItemModel item in _items) {
      if (item.id == id) {
        return item;
      }
    }
    return repository.getItemById(id);
  }

  void addItem({
    required String name,
    required String description,
    required String category,
    required double price,
    required double discount,
    required int stock,
    required int preparationTimeMinutes,
    required int calories,
    required bool isVeg,
    required bool isSpicy,
    required List<String> ingredients,
    required List<String> allergens,
  }) {
    repository.addItem(
      StoreItemModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        description: description,
        category: category,
        price: price,
        discount: discount,
        stock: stock,
        preparationTimeMinutes: preparationTimeMinutes,
        calories: calories,
        isVeg: isVeg,
        isSpicy: isSpicy,
        ingredients: ingredients,
        allergens: allergens,
      ),
    );
    loadItems();
  }

  void updateItem({
    required String id,
    required String name,
    required String description,
    required String category,
    required double price,
    required double discount,
    required int stock,
    required int preparationTimeMinutes,
    required int calories,
    required bool isVeg,
    required bool isSpicy,
    required List<String> ingredients,
    required List<String> allergens,
  }) {
    final StoreItemModel? existingItem = getItemById(id);
    if (existingItem == null) {
      return;
    }

    repository.updateItem(
      existingItem.copyWith(
        name: name,
        description: description,
        category: category,
        price: price,
        discount: discount,
        stock: stock,
        preparationTimeMinutes: preparationTimeMinutes,
        calories: calories,
        isVeg: isVeg,
        isSpicy: isSpicy,
        ingredients: ingredients,
        allergens: allergens,
      ),
    );
    loadItems();
  }
}
