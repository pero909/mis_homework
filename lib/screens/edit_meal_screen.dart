import 'package:flutter/material.dart';
import 'package:mis_homework/utils/meal.dart';

class EditMealScreen extends StatefulWidget {
  final String mealType;
  final String date;
  final Meal? prePopulatedMeal;

  const EditMealScreen({
    Key? key,
    required this.mealType,
    required this.date,
    this.prePopulatedMeal,
  }) : super(key: key);

  @override
  State<EditMealScreen> createState() => _EditMealScreenState();
}

class _EditMealScreenState extends State<EditMealScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatsController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();


  @override
  void initState() {
    super.initState();

    // Initialize controllers with pre-populated data, if available
    _nameController.text = widget.prePopulatedMeal?.name ?? '';
    _proteinsController.text = widget.prePopulatedMeal?.proteins.toString() ?? '';
    _carbsController.text = widget.prePopulatedMeal?.carbs.toString() ?? '';
    _fatsController.text = widget.prePopulatedMeal?.fats.toString() ?? '';
    _caloriesController.text = widget.prePopulatedMeal?.calories.toString() ?? '';
  }

  void _saveMeal() {
    // Create a new Meal object with all required fields
    final Meal newMeal = Meal(
      name: _nameController.text,
      calories: int.tryParse(_caloriesController.text) ?? 0,
      proteins: int.tryParse(_proteinsController.text) ?? 0,
      carbs: int.tryParse(_carbsController.text) ?? 0,
      fats: int.tryParse(_fatsController.text) ?? 0,
      date: widget.date,
      type: widget.mealType,
    );

    Navigator.pop(context, newMeal); // Pass the new meal back to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Meal'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputField(label: 'Name', controller: _nameController),
            const SizedBox(height: 16),
            _buildInputField(label: 'Proteins', controller: _proteinsController),
            const SizedBox(height: 16),
            _buildInputField(label: 'Carbs', controller: _carbsController),
            const SizedBox(height: 16),
            _buildInputField(label: 'Fats', controller: _fatsController),
            const SizedBox(height: 16),
            _buildInputField(label: 'Total Calories', controller: _caloriesController),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: _saveMeal,
              icon: const Icon(Icons.save_as_sharp),
              label: const Text('Save Meal'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({required String label, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:
          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter $label here...',
            filled: true,
            fillColor: Colors.white,
            border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          keyboardType:
          label == 'Total Calories' || label == 'Proteins' || label == 'Carbs' || label == 'Fats'
              ? TextInputType.number
              : TextInputType.text,
        ),
      ],
    );
  }
}