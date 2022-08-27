import 'package:flutter/material.dart';

void main() {
  runApp(BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Transferlist(),
      ),
    );
  }
}

class TransferForm extends StatelessWidget {
  final TextEditingController _accountNumberControllerField =
      TextEditingController();
  final TextEditingController _valueControllerField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Criando Transferência"),
      ),
      body: Column(
        children: [
          Editor(
            controller: _accountNumberControllerField,
            label: 'Número da conta',
            tip: '0000',
          ),
          Editor(
              controller: _valueControllerField,
              label: 'Valor',
              tip: '0,00',
              icon: Icons.monetization_on),
          ElevatedButton(
            onPressed: () => _createTransfer(context),
            child: Text("Confirmar"),
          ),
        ],
      ),
    );
  }

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberControllerField.text);
    final double? value = double.tryParse(_valueControllerField.text);

    if (accountNumber != null && value != null) {
      final createdTransfer = Transfer(value, accountNumber);
      Navigator.pop(context, createdTransfer);
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? tip;
  final IconData? icon;

  Editor({this.controller, this.label, this.tip, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        16,
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 24,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: tip,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class Transferlist extends StatefulWidget {
  final List<Transfer> _transfers = [];

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
        title: Text("Transferências"),
      ),
      body: ListView.builder(
          itemCount: widget._transfers.length,
          itemBuilder: (context, index) {
            final transfer = widget._transfers[index];
            return TransferItem(transfer);
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transfer?> future =
              Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return TransferForm();
            },
          ));
          future.then((transfer) {
            if(transfer != null) {
              widget._transfers.add(transfer!);
            }
          });
        },
      ),
    );
  }
}

class TransferItem extends StatelessWidget {
  final Transfer _transfer;

  TransferItem(this._transfer);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transfer.value.toString()),
      subtitle: Text(_transfer.accountNumber.toString()),
    ));
  }
}

class Transfer {
  final double value;
  final int accountNumber;

  Transfer(this.value, this.accountNumber);

  @override
  String toString() {
    return 'Transfer{value: $value, accountNumber: $accountNumber}';
  }
}
