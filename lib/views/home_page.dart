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
  final List<Transaction> _transactions = [
    Transaction(
      id: 't0',
      title: "Conta Antiga",
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 33)),
    ),
    Transaction(
      id: 't1',
      title: "Novo Tênis de Corrida",
      value: 310.76,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't2',
      title: "Conta de Luz",
      value: 211.30,
      date: DateTime.now().subtract(const Duration(days: 4)),
    )
  ];

  List<Transaction> get _recentTransaction {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    // criar um verificador se o usuário deseja add mais contas,
    // para ficar marcado e não sair do modal.
    // um checkbox, talvez.
    Navigator.of(context).pop();
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
                          // Row(
                          //   children: [],
                          // ),
                          Chart(recentTransaction: _recentTransaction),
                          TransactionList(transactions: _transactions),
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
