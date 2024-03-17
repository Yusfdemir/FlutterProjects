import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                // toStringAsFixed(2)--> virgülden sonra 2 basamak şeklinde yazırır 12.3433 --> 12.34
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(),
                // Spacer önündeki ve arkasındaki widgetların arasındaki tüm alanı kaplamaya çalışır yani burada yukarıdaki text widgetı sola aşşağıdakı row widgetıda sağa yaslayaktır
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    // formattedDate metot değil getter'dır ondan dolayı formattedDate() şeklinde değil formattedDate şeklinde kullanılır
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
