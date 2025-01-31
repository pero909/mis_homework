import 'package:flutter/material.dart';

class DateNavigation extends StatelessWidget {
  final DateTime currentDate;
  final Function(DateTime) onDateChanged;

  const DateNavigation({
    Key? key,
    required this.currentDate,
    required this.onDateChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Previous Button
        ElevatedButton(
          onPressed: () {
            onDateChanged(currentDate.subtract(const Duration(days: 1)));
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text(
            'Prev',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),

        // Current Date Display
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(20), // Elongated rounded rectangle
          ),
          child: Text(
            _formatDate(currentDate),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),

        // Next Button
        ElevatedButton(
          onPressed: () {
            onDateChanged(currentDate.add(const Duration(days: 1)));
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ],
    );
  }

  // Helper function to format the date
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == tomorrow) {
      return 'Tomorrow';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];

      String dayName = days[date.weekday - 1];
      String monthName = months[date.month - 1];
      return '$dayName, ${date.day} $monthName';
    }
  }
}
