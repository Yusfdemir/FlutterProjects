import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/controller/meals_controller.dart';

// import 'package:meals/screens/tabs.dart';
// import 'package:meals/widgets/main_drawer.dart';
enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatelessWidget {
  FiltersScreen({
    super.key,
  });

  final _mealsController = Get.find<MealsController>();

  @override
  // void initState() {
  //   super.initState();
  //   _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
  //   _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
  //   _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
  //   _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      // drawer: MainDrawer(onSelectScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == "meals") {
      //  push stack'e(sayfanın üzerine)yeni sayfa ekler ondan dolayı geri tuşu kullanılabilir pushReplacement var olan sayfayı hedef sayfa ile değiştirir ondan dolayı geri tuşu bizi uygulamadan çıkarır
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(
      //         builder: (ctx) => const TabsScreen(),
      //       ),
      //     );
      //   }
      // }),
      body: Obx(
        () => PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) return;
            Navigator.of(context).pop({
              Filter.glutenFree: _mealsController.glutenFreeFilterSet.value,
              Filter.lactoseFree: _mealsController.lactoseFreeFilterSet.value,
              Filter.vegetarian: _mealsController.vegetarianFilterSet.value,
              Filter.vegan: _mealsController.veganFilterSet.value,
            });
          },
          child: Column(
            children: [
              SwitchListTile(
                value: _mealsController.glutenFreeFilterSet.value,
                onChanged: (isChecked) {
                  _mealsController.setGlutenFreeFilterSet(isChecked);
                },
                title: Text(
                  "Gluten-free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  "Only include gluten-free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
              ),
              SwitchListTile(
                value: _mealsController.lactoseFreeFilterSet.value,
                onChanged: (isChecked) {
                  _mealsController.setLactoseFreeFilterSet(isChecked);
                },
                title: Text(
                  "Lactose-free",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  "Only include lactose-free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
              ),
              SwitchListTile(
                value: _mealsController.vegetarianFilterSet.value,
                onChanged: (isChecked) {
                  _mealsController.setVegetarinFilterSet(isChecked);
                },
                title: Text(
                  "Vegetarian",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  "Only include vegetarian meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
              ),
              SwitchListTile(
                value: _mealsController.veganFilterSet.value,
                onChanged: (isChecked) {
                  _mealsController.setVeganFilterSet(isChecked);
                },
                title: Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                subtitle: Text(
                  "Only include vegan meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(
                  left: 34,
                  right: 22,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
