import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery/data/categories.dart';
import 'package:grocery/models/category.dart';
import 'package:grocery/models/grocery_item.dart';
import 'package:grocery/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryController extends GetxController {
  //groceryList
  RxList<GroceryItem> _groceryItems = <GroceryItem>[].obs;
  var _isLoading = true.obs;
  RxString? _error;

  //NewItem
  final formKey = GlobalKey<FormState>();
  var enteredName = "".obs;
  var enteredQuantity = 1.obs;
  var selectedCategory = categories[Categories.vegetables]!;
  var isSending = false.obs;

//GroceryList
  List<GroceryItem> get groceryItems => _groceryItems.value;
  bool get isLoading => _isLoading.value;
  String? get error => _error?.value;

  @override
  void onInit() {
    super.onInit();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https("flutter-grocery-8dc72-default-rtdb.firebaseio.com",
        'shopping-list.json');

    try {
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        _error!.value = "Failed to fetch data. Please try again later";
      }
      if (response.body == "null") {
        _isLoading.value = false;
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> loadedItems = [];
      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value["category"])
            .value;
        loadedItems.add(
          GroceryItem(
            id: item.key,
            name: item.value['name'],
            quantity: item.value["quantity"],
            category: category,
          ),
        );
      }

      _groceryItems.value = loadedItems;
      _isLoading.value = false;
    } catch (err) {
      _error!.value = "Something went wrong! Please try again later";
    }
  }

  void addItem() async {
    Get.to(() => NewItem())?.then((value) => _groceryItems.add(value));
  }

  void removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);
    _groceryItems.remove(item);

    final url = Uri.https("flutter-grocery-8dc72-default-rtdb.firebaseio.com",
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _groceryItems.insert(index, item);
    }
  }

  void saveItem() async {
    //form içindeki validatorları çalıştırır
    if (formKey.currentState!.validate()) {
      //Form elemeanlarının onSaved metodunu çalıştırır
      formKey.currentState!.save();

      isSending.value = true;
      final url = Uri.https("flutter-grocery-8dc72-default-rtdb.firebaseio.com",
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': enteredName.value,
            'quantity': enteredQuantity.value,
            "category": selectedCategory.title,
          },
        ),
      );

      final Map<String, dynamic> resData = json.decode(response.body);

      if (!Get.context!.mounted) {
        return;
      }

      Get.back<GroceryItem>(
        result: GroceryItem(
          id: resData['name'],
          name: enteredName.value,
          quantity: enteredQuantity.value,
          category: selectedCategory,
        ),
      );
    }
  }

  void resetForm() {
    formKey.currentState!.reset();
  }
}
