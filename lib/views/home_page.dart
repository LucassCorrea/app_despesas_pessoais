import 'dart:math';

import 'package:app_despesas_pessoais/models/transaction.dart';
import 'package:app_despesas_pessoais/views/components/chart.dart';
import 'package:app_despesas_pessoais/views/components/transaction_form.dart';
import 'package:app_despesas_pessoais/views/components/transaction_list.dart';
// import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = false;

  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date, bool? isChecked) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    if (isChecked == false) {
      Navigator.of(context).pop();
    } else {
      return;
    }
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: const Text("Despesas Pessoais"),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(
              _showChart ? Icons.bar_chart : Icons.list,
            ),
          ),
      ],
    );
    final avaliableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (_showChart || !isLandscape)
                    SizedBox(
                      height: avaliableHeight * (isLandscape ? .94 : .29),
                      child: Chart(recentTransaction: _recentTransaction),
                    ),
                  if (!_showChart || !isLandscape)
                    SizedBox(
                      height: avaliableHeight * (isLandscape ? .94 : .63),
                      child: TransactionList(
                        transactions: _transactions,
                        removeTransactions: _removeTransaction,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: 'btn_floating',
          onPressed: () => _openTransactionFormModal(context),
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
