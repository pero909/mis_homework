import 'package:mis_homework/utils/meal.dart';


class MealDatabase {
  final List<Meal> _meals = []; // In-memory list to store meals

  // Add a new meal
  void addMeal(Meal meal) {
    _meals.add(meal);
  }

  // Get meals by date and type
  List<Meal> getMealsByDateAndType(String date, String type) {
    return _meals.where((meal) => meal.date == date && meal.type == type).toList();
  }
  void updateMeal(Meal updatedMeal) {
    // Find the index of the meal to update
    final index = _meals.indexWhere((meal) => meal.name == updatedMeal.name && meal.date == updatedMeal.date && meal.type == updatedMeal.type);

    if (index != -1) {
      _meals[index] = updatedMeal; // Replace with updated meal
    }
  }
  void deleteMeal(Meal mealToDelete) {
    _meals.removeWhere((meal) =>
    meal.name == mealToDelete.name &&
        meal.date == mealToDelete.date &&
        meal.type == mealToDelete.type);
  }
}