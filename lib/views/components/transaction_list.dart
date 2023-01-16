import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:app_despesas_pessoais/models/transaction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({
    super.key,
    required this.transactions,
    required this.removeTransactions,
  });

  final List<Transaction> transactions;
  final void Function(String) removeTransactions;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        return transactions.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/zzz.svg",
                    semanticsLabel: "zzz",
                    color: Colors.black,
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Nenhuma transação cadastrada",
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: 400,
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 5,
                      color: Colors.grey[350],
                    );
                  },
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tr = transactions[index];
                    return ListTile(
                      leading: Container(
                        height: 60,
                        width: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          AppLocalizations.of(context)!.valor_produto(tr.value),
                          maxLines: 1,
                          minFontSize: 1,
                          maxFontSize: 20,
                        ),
                      ),
                      title: AutoSizeText(
                        tr.title,
                        minFontSize: 1,
                        maxFontSize: 18,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      subtitle: AutoSizeText(
                        DateFormat('dd/MM/yy').format(tr.date),
                        minFontSize: 1,
                        maxFontSize: 12,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontFamily: "OpenSans",
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          removeTransactions(tr.id);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
