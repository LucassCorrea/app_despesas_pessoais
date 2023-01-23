import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:app_despesas_pessoais/models/transaction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({
    super.key,
    required this.transactions,
    required this.removeTransactions,
  });

  final List<Transaction> transactions;
  final void Function(String) removeTransactions;

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;
        return widget.transactions.isEmpty
            ? Container(
                height: maxHeight * .30,
                width: maxWidth,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/images/zzz.svg",
                      semanticsLabel: "zzz",
                      color: Colors.black,
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: AutoSizeText(
                        "Nenhuma transação cadastrada",
                        maxFontSize: 12,
                        minFontSize: 1,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 5,
                      color: Colors.grey[400],
                    );
                  },
                  // padding: const EdgeInsets.only(bottom: 10),
                  itemCount: widget.transactions.length,
                  itemBuilder: (context, index) {
                    final tr = widget.transactions[index];
                    return Dismissible(
                      key: ValueKey(tr),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.red,
                        // child: const Icon(Icons.delete),
                      ),
                      // secondaryBackground: Container(
                      //   color: Colors.green,
                      // ),
                      onDismissed: (direction) =>
                          widget.removeTransactions(tr.id),
                      child: ListTile(
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
                              AppLocalizations.of(context)!
                                  .valor_produto(tr.value),
                              maxLines: 1,
                              minFontSize: 8,
                              maxFontSize: 20,
                            ),
                          ),
                          title: AutoSizeText(
                            tr.title,
                            minFontSize: 12,
                            maxFontSize: 18,
                            stepGranularity: 2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
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
                          trailing: maxWidth > 480
                              ? TextButton.icon(
                                  onPressed: () {
                                    widget.removeTransactions(tr.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                  label: const AutoSizeText("Excluir"),
                                  style: TextButton.styleFrom(
                                    foregroundColor:
                                        Theme.of(context).errorColor,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                                    widget.removeTransactions(tr.id);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Theme.of(context).errorColor,
                                  ),
                                )),
                    );
                  },
                ),
              );
      },
    );
  }
}
