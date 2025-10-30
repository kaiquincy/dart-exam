import 'package:flutter/material.dart';
import 'screens/order_list_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Dart Orders',
    theme: ThemeData(primarySwatch: Colors.indigo),
    home: OrderListPage(),
  ));
}