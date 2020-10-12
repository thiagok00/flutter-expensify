import 'package:flutter/material.dart';
import './transaction_list_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function onDeleteTx;
  final double height;
  TransactionList({this.transactions, this.height, this.onDeleteTx});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text('No transactions added yet!',
                      style: Theme.of(context).textTheme.headline6),
                  SizedBox(height: 30,),
                  Container(height: 200, child: Image.asset('assets/images/waiting.png', fit: BoxFit.cover)),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return TransactionListItem(transaction: transactions[index],deleteTx: onDeleteTx,);
                },
                itemCount: transactions.length,
              ));
  }
}
