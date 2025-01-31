import 'package:flutter/material.dart';

class TopSection extends StatelessWidget {
  final int totalCalories;
  final int eatenCalories;

  final Function(int) onTotalCaloriesChanged; // Callback for updating total calories

  const TopSection({
    Key? key,
    required this.totalCalories,
    required this.eatenCalories,
    required this.onTotalCaloriesChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade300, Colors.purple.shade900],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Battery Image
          Image.asset(
            'assets/battery.png',
            height: 120,
            width: 120,
          ),
          const SizedBox(width: 16), // Space between battery and text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            decoration:
                            const InputDecoration(border: UnderlineInputBorder()),
                            textAlign: TextAlign.center,
                            controller:
                            TextEditingController(text: totalCalories.toString()),
                            onSubmitted: (value) {
                              int newValue = int.tryParse(value) ?? totalCalories;
                              onTotalCaloriesChanged(newValue); // Notify parent widget
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Calories',
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Eaten:',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Row(
                      children: [
                        Text(
                          '$eatenCalories',
                          style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Calories',
                          style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
