import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meals/controller/meals_controller.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  MealDetailScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;
  final _mealsController = Get.find<MealsController>();

  @override
  Widget build(BuildContext context) {
    void showInfoMessage(String message) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }

    void toggleMealfavorite(meal) {
      var isExisting = _mealsController.favoriteMeals.value.contains(meal);
      if (isExisting) {
        _mealsController.removeMealFromFavorite(meal);
        showInfoMessage("Meal is no longer a favorite.");
      } else {
        _mealsController.addMealToFavorite(meal);
        showInfoMessage("Marked as a favorite");
      }
    }

    final favoriteMeals = _mealsController.favoriteMeals.value;
    final isFavorite = favoriteMeals.contains(meal);
    return Scaffold(
        appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
              onPressed: () {
                toggleMealfavorite(meal);
              },
              icon: Icon(isFavorite ? Icons.star : Icons.star_border),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.network(
                meal.imageUrl,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 14),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final ingredient in meal.ingredients)
                Text(
                  ingredient,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              const SizedBox(height: 24),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 14),
              for (final step in meal.steps)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(
                    step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ),
            ],
          ),
        ));
  }
}
