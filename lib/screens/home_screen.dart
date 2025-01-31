import 'package:flutter/material.dart';
import 'package:mis_homework/screens/edit_meal_screen.dart';
import 'package:mis_homework/utils/meal.dart';
import '../widgets/top_section.dart';
import '../widgets/date_navigation_section.dart';
import '../widgets/meal_cards.dart';
import '../database/meal_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalCalories = 1700;
  int eatenCalories = 0;
  DateTime currentDate = DateTime.now();

  final MealDatabase mealDatabase = MealDatabase(); // Initialize database

  void updateTotalCalories(int newTotal) {
    setState(() {
      totalCalories = newTotal;
    });
  }

  void _updateDate(DateTime newDate) {
    setState(() {
      currentDate = newDate;
    });
  }
  void _refreshUI() {
    setState(() {});
  }
  void _addMeal(String mealType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditMealScreen(
          mealType: mealType,
          date:
          '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
        ),
      ),
    ).then((result) {
      if (result != null && result is Meal) {
        setState(() {
          mealDatabase.addMeal(result);
          eatenCalories += result.calories; // Update eaten calories dynamically
        });
        _refreshUI();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Eatly'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top Section
            TopSection(
              totalCalories: totalCalories,
              eatenCalories: eatenCalories,
              onTotalCaloriesChanged: updateTotalCalories,
            ),

            const SizedBox(height: 20),

            // Date Navigation Section
            DateNavigation(
              currentDate: currentDate,
              onDateChanged: _updateDate,
            ),

            const SizedBox(height: 20),

            // Meal Cards Section
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Number of meal types (Breakfast, Lunch, Dinner)
                itemBuilder: (context, index) {
                  final mealTypes = ['Breakfast', 'Lunch', 'Dinner'];
                  final mealType = mealTypes[index];

                  return MealCard(
                    mealType: mealType,
                    date:
                    '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}',
                    mealDatabase: mealDatabase,
                    onAddMeal: () => _addMeal(mealType),
                    onRefresh: _refreshUI,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
