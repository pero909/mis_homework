import 'package:flutter/material.dart';
import 'package:mis_homework/screens/edit_meal_screen.dart';
import 'package:mis_homework/utils/meal.dart';
import '../database/meal_database.dart';

class MealCard extends StatelessWidget {
  final String mealType;
  final VoidCallback onAddMeal;
  final VoidCallback onRefresh;
  final String date; // Current date
  final MealDatabase mealDatabase; // Reference to the database

  const MealCard({
    Key? key,
    required this.mealType,
    required this.onAddMeal,
    required this.date,
    required this.mealDatabase,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch meals dynamically from the database
    final List<Meal> meals = mealDatabase.getMealsByDateAndType(date, mealType);

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8), // Space between cards
      color: Colors.purple.shade100, // Light purple background
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded edges
      ),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal Type Text
              Text(
                mealType,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Scrollable List of Meals
              Expanded(
                child: meals.isEmpty
                    ? Center(
                  child: Text(
                    'No meals added yet',
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                )
                    : ListView.builder(
                  itemCount: meals.length,
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Meal Name and Calories
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    meal.name,
                                    style: const TextStyle(fontSize: 16, color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '${meal.calories} cal',
                                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                                ),
                              ],
                            ),
                          ),

                          // Edit Button
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.purple),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditMealScreen(
                                    mealType: meal.type,
                                    date: meal.date,
                                    prePopulatedMeal: meal, // Pass the current meal for editing
                                  ),
                                ),
                              ).then((updatedMeal) {
                                if (updatedMeal != null && updatedMeal is Meal) {
                                  mealDatabase.updateMeal(updatedMeal); // Update in database
                                  (context as Element).markNeedsBuild(); // Refresh MealCard UI dynamically
                                }
                                onRefresh();

                              });
                            },
                          ),

                          // Delete Button
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              mealDatabase.deleteMeal(meal); // Remove from database
                              (context as Element).markNeedsBuild();
                              onRefresh();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 8),

              // Add Meal Button
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton.icon(
                  onPressed: onAddMeal,
                  icon:
                  const Icon(Icons.add, color: Colors.purple),
                  label:
                  const Text('Add Meal', style: TextStyle(color: Colors.purple)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
