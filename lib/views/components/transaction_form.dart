import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({
    super.key,
    required this.onSubmit,
  });

  final void Function(String, double, DateTime) onSubmit;

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

    widget.onSubmit(title, value, _selectedDate);
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
              // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onSubmitted: (_) => _submitForm(),
              style: Theme.of(context).textTheme.labelMedium,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valor (R\$)",
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: [
                  Text(
                    "Data selecionada: ${DateFormat("dd/MM/yy").format(_selectedDate)}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      _datePicker();
                    },
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
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
