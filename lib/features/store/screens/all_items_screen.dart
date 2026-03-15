import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../controllers/store_items_controller.dart';
import '../domain/models/store_item_model.dart';
import '../widgets/empty_state.dart';
import '../widgets/item_card.dart';

class AllItemsScreen extends StatelessWidget {
  const AllItemsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return GetBuilder<StoreItemsController>(
      builder: (storeItemsController) {
        final List<StoreItemModel> items = storeItemsController.filteredItems;

        return Scaffold(
          appBar: AppBar(
            title: const Text(''),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => context.push('/dashboard/store/add-item'),
            backgroundColor: Colors.green.shade100,
            icon: const Icon(Icons.add), label: const Text('Add Item'),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
            children: [
              Text('Food Items',
                style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700,),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: storeItemsController.categories.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final String category = storeItemsController.categories[index];
                    final bool isSelected = category == storeItemsController.selectedCategory;
                    return ChoiceChip(
                      selectedColor: Colors.green.shade100,
                      label: Text(category),
                      selected: isSelected,
                      onSelected: (_) => storeItemsController.selectCategory(category),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '${items.length} item${items.length == 1 ? '' : 's'}',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600,),
              ),
              const SizedBox(height: 16),
              if (items.isEmpty)
                EmptyState(category: storeItemsController.selectedCategory)
              else
                ...items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ItemCard(item: item),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}





