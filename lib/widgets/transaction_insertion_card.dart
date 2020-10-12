import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionInsertionCard extends StatefulWidget {
  final Function onAdd;

  TransactionInsertionCard({this.onAdd});

  @override
  _TransactionInsertionCardState createState() =>
      _TransactionInsertionCardState();
}

class _TransactionInsertionCardState extends State<TransactionInsertionCard> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (titleController.text.isEmpty || _selectedDate == null) return;
    try {
      double amount = double.parse(amountController.text);
      if (amount > 0) {
        widget.onAdd(titleController.text, amount, _selectedDate);
        Navigator.of(context).pop();
      }
    } catch (err) {
      return;
    }
  }

  void _presentDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return SingleChildScrollView(
          child: Card(
        child: Container(
          padding: EdgeInsets.only(top:10, left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(_selectedDate != null
                          ? 'Picked date: ${DateFormat.yMd().format(_selectedDate)}'
                          : 'No Date Chosen!')),
                  FlatButton(
                      textColor: theme.primaryColor,
                      child: Text('Choose Date',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () => _presentDatePicker(context)),
                ],
              ),
              RaisedButton(
                onPressed: _submitData,
                color: theme.primaryColor,
                textColor: theme.textTheme.button.color,
                child: Text(
                  'Add transaction',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
