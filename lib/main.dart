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
        body: TransferForm(),
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
          Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: TextField(
              controller: _accountNumberControllerField,
              style: TextStyle(
                fontSize: 24,
              ),
              decoration: InputDecoration(
                labelText: "Número da conta",
                hintText: "0000",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              16,
            ),
            child: TextField(
              controller: _valueControllerField,
              style: TextStyle(
                fontSize: 24,
              ),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.monetization_on,
                ),
                labelText: "Valor",
                hintText: "0,00",
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final int? accountNumber =
                  int.tryParse(_accountNumberControllerField.text);
              final double? value = double.tryParse(_valueControllerField.text);

              if (accountNumber != null && value != null) {
                final createdTransfer = Transfer(value, accountNumber);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$createdTransfer"),
                    action: SnackBarAction(
                      label: "Action",
                      onPressed: () {},
                    ),
                  ),
                );
              }
            },
            child: Text("Confirmar"),
          ),
        ],
      ),
    );
  }
}

class Transferlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Transferências"),
      ),
      body: Column(
        children: [
          TransferItem(Transfer(100.0, 1010)),
          TransferItem(Transfer(200.0, 101040)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
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
