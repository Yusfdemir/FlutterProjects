import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/controller/grocery_controller.dart';

class GroceryList extends StatelessWidget {
  GroceryList({super.key});
  final _groceryController = Get.put(GroceryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _groceryController.addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Obx(
        () => _groceryController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _groceryController.error != null
                ? Center(
                    child: Text(_groceryController.error!),
                  )
                : _groceryController.groceryItems.isEmpty
                    ? const Center(
                        child: Text("No items added yet"),
                      )
                    : ListView.builder(
                        itemCount: _groceryController.groceryItems.length,
                        itemBuilder: (ctx, index) => Dismissible(
                          key: ValueKey(_groceryController.groceryItems[index]),
                          onDismissed: (direction) {
                            _groceryController.removeItem(
                                _groceryController.groceryItems[index]);
                          },
                          child: ListTile(
                            title: Text(
                                _groceryController.groceryItems[index].name),
                            leading: Container(
                              width: 24,
                              height: 24,
                              color: _groceryController
                                  .groceryItems[index].category.color,
                            ),
                            trailing: Text(
                              _groceryController.groceryItems[index].quantity
                                  .toString(),
                            ),
                          ),
                        ),
                      ),
      ),
    );
  }
}
