import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/store_items_controller.dart';
import '../data/store_items_repository.dart';
import '../domain/models/store_item_model.dart';

class AddItemScreen extends StatefulWidget {
  final String? itemId;

  const AddItemScreen({super.key, this.itemId});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _preparationTimeController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _allergensController = TextEditingController();

  late final bool _isEdit;
  late String _selectedCategory;
  bool _isVeg = false;
  bool _isSpicy = false;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.itemId != null;
    _selectedCategory = StoreItemsRepository.baseCategories.first;

    if (_isEdit) {
      final StoreItemModel? item =
          Get.find<StoreItemsController>().getItemById(widget.itemId!);
      if (item != null) {
        _selectedCategory = item.category;
        _nameController.text = item.name;
        _descriptionController.text = item.description;
        _priceController.text = item.price.toStringAsFixed(2);
        _discountController.text = item.discount.toStringAsFixed(2);
        _stockController.text = item.stock.toString();
        _preparationTimeController.text = item.preparationTimeMinutes.toString();
        _caloriesController.text = item.calories.toString();
        _ingredientsController.text = item.ingredients.join(', ');
        _allergensController.text = item.allergens.join(', ');
        _isVeg = item.isVeg;
        _isSpicy = item.isSpicy;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _stockController.dispose();
    _preparationTimeController.dispose();
    _caloriesController.dispose();
    _ingredientsController.dispose();
    _allergensController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Update Item' : 'Add Item'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Food Information',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This form is configured for food items only.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField(
              controller: _nameController,
              label: 'Food name',
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'Enter food name' : null,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _descriptionController,
              label: 'Description',
              minLines: 3,
              maxLines: 4,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter food description'
                  : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: StoreItemsRepository.baseCategories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _priceController,
                    label: 'Price',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: _validatePositiveNumber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _discountController,
                    label: 'Discount',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: _validateOptionalNumber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField(
                    controller: _stockController,
                    label: 'Stock',
                    keyboardType: TextInputType.number,
                    validator: _validateWholeNumber,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTextField(
                    controller: _preparationTimeController,
                    label: 'Prep Time (min)',
                    keyboardType: TextInputType.number,
                    validator: _validateWholeNumber,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _caloriesController,
              label: 'Calories',
              keyboardType: TextInputType.number,
              validator: _validateWholeNumber,
            ),
            const SizedBox(height: 20),
            SwitchListTile.adaptive(
              value: _isVeg,
              onChanged: (value) {
                setState(() {
                  _isVeg = value;
                });
              },
              title: const Text('Vegetarian'),
              contentPadding: EdgeInsets.zero,
            ),
            SwitchListTile.adaptive(
              value: _isSpicy,
              onChanged: (value) {
                setState(() {
                  _isSpicy = value;
                });
              },
              title: const Text('Spicy'),
              contentPadding: EdgeInsets.zero,
            ),
            const SizedBox(height: 12),
            _buildTextField(
              controller: _ingredientsController,
              label: 'Ingredients',
              minLines: 2,
              maxLines: 3,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter ingredients'
                  : null,
              helperText: 'Separate with commas',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _allergensController,
              label: 'Allergens',
              minLines: 2,
              maxLines: 3,
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Enter allergens'
                  : null,
              helperText: 'Separate with commas',
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _submit,
              icon: Icon(_isEdit ? Icons.update : Icons.save),
              label: Text(_isEdit ? 'Update Item' : 'Save Item'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? helperText,
    TextInputType? keyboardType,
    int minLines = 1,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(labelText: label, helperText: helperText, border: const OutlineInputBorder(),),
    );
  }

  String? _validatePositiveNumber(String? value) {
    final double? number = double.tryParse(value ?? '');
    if (number == null || number <= 0) {
      return 'Enter a valid amount';
    }
    return null;
  }

  String? _validateOptionalNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final double? number = double.tryParse(value);
    if (number == null || number < 0) {
      return 'Enter a valid discount';
    }
    return null;
  }

  String? _validateWholeNumber(String? value) {
    final int? number = int.tryParse(value ?? '');
    if (number == null || number < 0) {
      return 'Enter a valid number';
    }
    return null;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final StoreItemsController controller = Get.find<StoreItemsController>();
    final List<String> ingredients = _splitList(_ingredientsController.text);
    final List<String> allergens = _splitList(_allergensController.text);

    if (_isEdit) {
      controller.updateItem(
        id: widget.itemId!,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        price: double.parse(_priceController.text.trim()),
        discount: _discountController.text.trim().isEmpty ? 0 : double.parse(_discountController.text.trim()),
        stock: int.parse(_stockController.text.trim()),
        preparationTimeMinutes: int.parse(_preparationTimeController.text.trim()),
        calories: int.parse(_caloriesController.text.trim()),
        isVeg: _isVeg,
        isSpicy: _isSpicy,
        ingredients: ingredients,
        allergens: allergens,
      );
    } else {
      controller.addItem(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        category: _selectedCategory,
        price: double.parse(_priceController.text.trim()),
        discount: _discountController.text.trim().isEmpty ? 0 : double.parse(_discountController.text.trim()),
        stock: int.parse(_stockController.text.trim()),
        preparationTimeMinutes: int.parse(_preparationTimeController.text.trim()),
        calories: int.parse(_caloriesController.text.trim()),
        isVeg: _isVeg,
        isSpicy: _isSpicy,
        ingredients: ingredients,
        allergens: allergens,
      );
    }
    Navigator.of(context).pop();
  }

  List<String> _splitList(String rawValue) {
    return rawValue.split(',').map((value) => value.trim()).where((value) => value.isNotEmpty).toList();
  }
}
