class Meal {
  final String name; // Meal name
  final int calories; // Total calories
  final int proteins; // Proteins in grams
  final int carbs; // Carbs in grams
  final int fats; // Fats in grams
  final String date; // Date in YYYY-MM-DD format
  final String type; // Meal type (Breakfast, Lunch, Dinner)

  Meal({
    required this.name,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fats,
    required this.date,
    required this.type,
  });
}
