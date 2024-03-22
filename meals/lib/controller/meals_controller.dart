import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';

class MealsController extends GetxController {
  RxList<Meal> favoriteMeals = <Meal>[].obs;
  var selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  }.obs;
  RxList<Meal> availableMeals = dummyMeals.obs;
  var glutenFreeFilterSet = false.obs;
  var lactoseFreeFilterSet = false.obs;
  var vegetarianFilterSet = false.obs;
  var veganFilterSet = false.obs;
  var selectedPageIndex = 0.obs;
  var activePageTitle = "Categories".obs;

  void addMealToFavorite(Meal meal) {
    favoriteMeals.value.add(meal);
  }

  void removeMealFromFavorite(Meal meal) {
    favoriteMeals.value.remove(meal);
  }

  void selectPage(int index) {
    selectedPageIndex.value = index;
    selectedPageIndex.value == 1
        ? activePageTitle.value = "Your favorites"
        : activePageTitle.value = "Categories";
  }

  void setSelectedFilters(Map<Filter, bool>? result) {
    if (result != null) {
      selectedFilters.value = result;
    }
    print(selectedFilters.value);
  }

  void setGlutenFreeFilterSet(bool isChecked) {
    glutenFreeFilterSet.value = isChecked;
  }

  void setLactoseFreeFilterSet(bool isChecked) {
    lactoseFreeFilterSet.value = isChecked;
  }

  void setVegetarinFilterSet(bool isChecked) {
    vegetarianFilterSet.value = isChecked;
  }

  void setVeganFilterSet(bool isChecked) {
    veganFilterSet.value = isChecked;
  }

  void setAvailableMeals() {
    availableMeals.value = dummyMeals.where((meal) {
      if (selectedFilters.value[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (selectedFilters.value[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (selectedFilters.value[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (selectedFilters.value[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
  }
}
