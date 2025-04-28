import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/app_drawer.dart';
import 'package:shopapp/components/order_component.dart';
import 'package:shopapp/models/order_list.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshOrders();
  }

  Future<void> _refreshOrders() {
    return Provider.of<OrderList>(
      context, 
      listen: false)
    .loadOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final OrderList orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos')),
      drawer: AppDrawer(),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: () => _refreshOrders(),
                child: ListView.builder(
                  itemCount: orders.itemCount,
                  itemBuilder:
                      (ctx, index) =>
                          OrderComponent(order: orders.items[index]),
                ),
              ),
    );
  }
}
