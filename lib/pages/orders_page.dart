import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/app_drawer.dart';
import 'package:shopapp/components/order_component.dart';
import 'package:shopapp/models/order_list.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos')),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.itemCount,
        itemBuilder: (ctx, index) => OrderComponent(order: orders.items[index]),
      ),
    );
  }
}
