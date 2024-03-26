import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/controller/grocery_controller.dart';
import 'package:grocery/data/categories.dart';

class NewItem extends StatelessWidget {
  NewItem({super.key});
  final _groceryController = Get.find<GroceryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new item"),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _groceryController.formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "Must be between 1 and 50 charters.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _groceryController.enteredName.value = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      // Row gibi TextFormField ta yatay olarak kısıtlanmamıştır ondan dolayı Expanded ile sarmalamak lazım
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text("Quantity"),
                        ),
                        keyboardType: TextInputType.number,
                        initialValue:
                            _groceryController.enteredQuantity.value.toString(),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return "Must be a valid positive number.";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _groceryController.enteredQuantity.value =
                              int.parse(newValue!);
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Aynı olay DropdownButtonFormField içinde geçerli
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _groceryController.selectedCategory,
                        decoration:
                            const InputDecoration(labelText: "Category"),
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(category.value.title)
                                  ],
                                ))
                        ],
                        onChanged: (value) {
                          _groceryController.selectedCategory = value!;
                        },
                      ),
                    ),
                  ],
                ), //instead of TextField()
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _groceryController.isSending.value
                          ? null
                          : () {
                              _groceryController.resetForm();
                            },
                      child: const Text("Reset"),
                    ),
                    ElevatedButton(
                      onPressed: _groceryController.isSending.value
                          ? null
                          : _groceryController.saveItem,
                      child: _groceryController.isSending.value
                          ? const SizedBox(
                              height: 16,
                              width: 16,
                              child: CircularProgressIndicator(),
                            )
                          : const Text("Add Item"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
