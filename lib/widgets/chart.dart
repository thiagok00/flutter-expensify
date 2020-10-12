import 'package:expensify/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final double height;

  Chart(this.recentTransactions, this.height);

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (var tx in recentTransactions) {
        if (tx.date.day == weekday.day &&
            tx.date.month == weekday.month &&
            tx.date.year == weekday.year) {
          totalSum += tx.amount;
        }
      }
      return {'day': DateFormat.E().format(weekday), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionsValues.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Card(
        margin: EdgeInsets.all(20),
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionsValues
                  .map((data) {
                    return Expanded(
                      child: ChartBar(
                          data['day'],
                          data['amount'],
                          totalSpending > 0
                              ? (data['amount'] as double) / totalSpending
                              : 0),
                    );
                  })
                  .toList()
                  .reversed
                  .toList()),
        ),
      ),
    );
  }
}
