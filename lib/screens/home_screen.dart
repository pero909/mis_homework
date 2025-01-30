import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Counter'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Battery and Calorie Info Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.battery_full, size: 40, color: Colors.purple),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text('Total: 2000 Calories', style: TextStyle(fontSize: 16)),
                      Text('Eaten: 0 Calories', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Current Date Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {}, // Placeholder for navigation
                ),
                Text(
                  'Today, January 30',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: () {}, // Placeholder for navigation
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Meal Categories Section
            Expanded(
              child: ListView(
                children: [
                  MealCard(mealType: 'Breakfast'),
                  MealCard(mealType: 'Lunch'),
                  MealCard(mealType: 'Dinner'),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Placeholder for navigation to Meal Creation Screen
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MealCard extends StatelessWidget {
  final String mealType;

  const MealCard({Key? key, required this.mealType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(mealType, style: const TextStyle(fontSize: 18)),
        trailing: IconButton(
          icon: const Icon(Icons.add, color: Colors.purple),
          onPressed: () {
            // Placeholder for adding a meal
          },
        ),
      ),
    );
  }
}
