import 'package:flutter/material.dart';
import '../models/order.dart';

class AddOrderPage extends StatefulWidget {
  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final itemCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final currCtrl = TextEditingController(text: 'USD');
  final qtyCtrl = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(controller: itemCtrl, decoration: InputDecoration(labelText: 'Item')),
              TextFormField(controller: nameCtrl, decoration: InputDecoration(labelText: 'Item Name')),
              TextFormField(controller: priceCtrl, decoration: InputDecoration(labelText: 'Price'), keyboardType: TextInputType.number),
              TextFormField(controller: currCtrl, decoration: InputDecoration(labelText: 'Currency')),
              TextFormField(controller: qtyCtrl, decoration: InputDecoration(labelText: 'Quantity'), keyboardType: TextInputType.number),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  final order = Order(
                    item: itemCtrl.text,
                    itemName: nameCtrl.text,
                    price: double.parse(priceCtrl.text),
                    currency: currCtrl.text,
                    quantity: int.parse(qtyCtrl.text),
                  );
                  Navigator.pop(context, order);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
