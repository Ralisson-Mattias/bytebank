import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transfer.dart';
import 'package:flutter/material.dart';

const _titleAppBar = "Criando Transferência";

const _accountNumberLabel = "Número da conta";
const _accountNumberTip = "0000";

const _valueLabel = "Valor";
const _valueTip = "0.00";

const _confirmLabel = "Confirmar";


class TransferForm extends StatefulWidget {
  const TransferForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TransferFormState();
  }
}

class TransferFormState extends State<TransferForm> {
  final TextEditingController _accountNumberControllerField =
      TextEditingController();
  final TextEditingController _valueControllerField = TextEditingController();

  void _createTransfer(BuildContext context) {
    final int? accountNumber = int.tryParse(_accountNumberControllerField.text);
    final double? value = double.tryParse(_valueControllerField.text);

    if (accountNumber != null && value != null) {
      final createdTransfer = Transfer(value, accountNumber);
      Navigator.pop(context, createdTransfer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_titleAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: _accountNumberControllerField,
              label: _accountNumberLabel,
              tip: _accountNumberTip,
            ),
            Editor(
                controller: _valueControllerField,
                label: _valueLabel,
                tip: _valueTip,
                icon: Icons.monetization_on),
            ElevatedButton(
              onPressed: () => _createTransfer(context),
              child: const Text(_confirmLabel),
            ),
          ],
        ),
      ),
    );
  }
}
