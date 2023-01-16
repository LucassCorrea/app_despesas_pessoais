import 'dart:math';

import 'package:app_despesas_pessoais/models/transaction.dart';
import 'package:app_despesas_pessoais/views/components/chart.dart';
import 'package:app_despesas_pessoais/views/components/transaction_form.dart';
import 'package:app_despesas_pessoais/views/components/transaction_list.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [];

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
      builder: (context) {
        return TransactionForm(onSubmit: _addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Despesas Pessoais"),
      ),
      body: LayoutBuilder(
        builder: (context, constrains) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Chart(recentTransaction: _recentTransaction),
                          TransactionList(
                            transactions: _transactions,
                            removeTransactions: _removeTransaction,
                          ),
                        ],
                      ),
                    ),
                  ],
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
    );
  }
}
