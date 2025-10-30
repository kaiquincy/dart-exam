import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/order.dart';

class OrderStorage {
  static Future<List<Order>> loadOrders() async {
    final data = await rootBundle.loadString('assets/order.json');
    final list = jsonDecode(data) as List;
    return list.map((e) => Order.fromJson(e)).toList();
  }

  static Future<void> saveOrders(List<Order> orders) async {
    // Simulation only - in real app use local storage or backend API
    print(jsonEncode(orders.map((e) => e.toJson()).toList()));
  }
}
