import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/controller/meals_controller.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatelessWidget {
  TabsScreen({super.key});

  final _mealsController = Get.put(MealsController());

  @override
  Widget build(BuildContext context) {
    void setScreen(String identifier) async {
      Navigator.of(context)
          .pop(); //önce yan menüyü kapattık sonra gerekliyse filtersScreeni açtık
      if (identifier == "filters") {
        //  push stack'e(sayfanın üzerine)yeni sayfa ekler ondan dolayı geri tuşu kullanılabilir pushReplacement var olan sayfayı hedef sayfa ile değiştirir ondan dolayı geri tuşu bizi uygulamadan çıkarır
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FiltersScreen(),
          ),
        );
        _mealsController.setSelectedFilters(result);
        _mealsController.setAvailableMeals();
      }
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(_mealsController.activePageTitle.value),
        ),
        drawer: MainDrawer(
          onSelectScreen: setScreen,
        ),
        body: _mealsController.selectedPageIndex.value == 1
            ? MealsScreen(
                meals: _mealsController.favoriteMeals.value,
              )
            : CategoriesScreen(
                availableMeals: _mealsController.availableMeals.value,
              ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _mealsController.selectedPageIndex.value,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites"),
          ],
          onTap: _mealsController.selectPage,
        ),
      ),
    );
  }
}
