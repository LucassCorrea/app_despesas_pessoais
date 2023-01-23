import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.onSubmit,
  });

  final void Function(String, double, DateTime, bool?) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate, _isChecked);
  }

  _datePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  bool? _isChecked = false;

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        return Container(
          padding: EdgeInsets.only(
              top: maxHeight * .02,
              left: maxWidth * .02,
              right: maxWidth * .02,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          height: maxHeight,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  onSubmitted: (_) => _submitForm(),
                  style: Theme.of(context).textTheme.labelMedium,
                  decoration: const InputDecoration(
                    labelText: "Título",
                  ),
                ),
                TextField(
                  controller: _valueController,
                  onSubmitted: (_) => _submitForm(),
                  style: Theme.of(context).textTheme.labelMedium,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor (R\$)",
                  ),
                ),
                isLandscape
                    ? SizedBox(
                        height: maxHeight * .35,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      "Data selecionada: ${DateFormat("dd/MM/yy").format(_selectedDate)}",
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    OutlinedButton(
                                      onPressed: () {
                                        _datePicker();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.grey[300],
                                      ),
                                      child: const Text(
                                        "Selecionar Data",
                                        style: TextStyle(
                                          color: Colors.purple,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const AutoSizeText("Adicionar mais contas"),
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      value: _isChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          _isChecked = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text(
                                    "Nova Transação",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: maxHeight * .03),
                        height: maxHeight * .55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    _datePicker();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.grey[300],
                                  ),
                                  child: const AutoSizeText(
                                    "Selecionar Data",
                                    maxFontSize: 14,
                                    style: TextStyle(
                                      color: Colors.purple,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Data selecionada: ${DateFormat("dd/MM/yy").format(_selectedDate)}",
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: maxHeight * .05,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const AutoSizeText("Adicionar mais contas"),
                                  Checkbox(
                                    checkColor: Colors.white,
                                    activeColor: Theme.of(context).primaryColor,
                                    value: _isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        _isChecked = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: _submitForm,
                                  child: const Text(
                                    "Nova Transação",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
