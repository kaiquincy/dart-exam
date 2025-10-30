import 'package:flutter/material.dart';
import '../models/order.dart';
import '../utils/storage.dart';
import 'add_order_page.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  List<Order> orders = [];
  List<Order> filtered = [];
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  Future<void> _loadOrders() async {
    final list = await OrderStorage.loadOrders();
    setState(() {
      orders = list;
      filtered = list;
    });
  }

  void _search(String text) {
    setState(() {
      filtered = orders
          .where((o) => o.itemName.toLowerCase().contains(text.toLowerCase()))
          .toList();
    });
  }

  void _addOrder(Order order) {
    setState(() {
      orders.add(order);
      filtered = orders;
    });
    OrderStorage.saveOrders(orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Orders')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Search by ItemName',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _search,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final o = filtered[i];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(o.item.substring(1))),
                    title: Text(o.itemName),
                    subtitle: Text('${o.price} ${o.currency} × ${o.quantity}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newOrder = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddOrderPage()),
          );
          if (newOrder != null) _addOrder(newOrder);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
