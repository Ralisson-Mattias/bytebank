import 'package:bytebank/models/transfer.dart';
import 'package:bytebank/screens/transfer_form.dart';
import 'package:flutter/material.dart';

const _appBarTitle = "Transferências";

class Transferlist extends StatefulWidget {
  final List<Transfer> _transfers = [];

  Transferlist({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransferListState();
  }
}

class TransferListState extends State<Transferlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
      body: ListView.builder(
          itemCount: widget._transfers.length,
          itemBuilder: (context, index) {
            final transfer = widget._transfers[index];
            return TransferItem(transfer);
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final Future<Transfer?> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TransferForm();
              },
            ),
          );

          future.then((transfer) {
            _update(transfer);
          });
        },
      ),
    );
  }

  void _update(Transfer? transfer) {
    if (transfer != null) {
      setState(() {
        widget._transfers.add(transfer);
      });
    }
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  const TransferItem(this._transfer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
      leading: const Icon(Icons.monetization_on),
      title: Text(_transfer.value.toString()),
      subtitle: Text(_transfer.accountNumber.toString()),
    ));
  }
}
