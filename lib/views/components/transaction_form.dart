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
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Data selecionada: ${DateFormat("dd/MM/yy").format(_selectedDate)}",
                          style: Theme.of(context).textTheme.bodySmall,
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
                    Row(
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
                    )
                  ],
                ),
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
    );
  }
}
