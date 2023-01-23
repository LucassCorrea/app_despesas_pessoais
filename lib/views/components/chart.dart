import 'package:app_despesas_pessoais/models/transaction.dart';
import 'package:app_despesas_pessoais/views/components/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({
    super.key,
    required this.recentTransaction,
  });

  final List<Transaction> recentTransaction;

  List<Map<String, dynamic>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (int i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {
        'day': DateFormat.E("pt_BR").format(weekDay)[0].toUpperCase(),
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) {
      return sum + tr["value"];
    });
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context);

    groupedTransactions;
    return LayoutBuilder(builder: (ctx, constraints) {
      return Card(
        elevation: 8,
        margin: EdgeInsets.all(constraints.maxHeight * .06),
        child: Row(
          children: groupedTransactions.map((tr) {
            return Expanded(
              flex: 1,
              child: ChartBar(
                label: tr['day'].toString(),
                value: tr['value'],
                percentage:
                    _weekTotalValue == 0 ? 0 : tr['value'] / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
