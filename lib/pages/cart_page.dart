import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/cart_component.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/order_list.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text('Carrinho de compras')),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 10),
                  Chip(
                    shape: StadiumBorder(),
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                  Spacer(),
                  CartButton(cart: cart),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, index) => CartComponent(items[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class CartButton extends StatefulWidget {
  const CartButton({super.key, required this.cart});

  final Cart cart;

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading 
    ? CircularProgressIndicator()
    : TextButton(
      onPressed:
          widget.cart.itemCount == 0
              ? null
              : () async {
               setState(() => _isLoading = true); 
                await Provider.of<OrderList>(
                  context,
                  listen: false,
                ).addOrder(widget.cart);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Text('Compra efetuada com sucesso'),
                        SizedBox(width: 5),
                        Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                    duration: Duration(seconds: 2),
                  ),
                );
                widget.cart.clear();
                setState(() => _isLoading = false);
              },
      style: TextButton.styleFrom(
        textStyle: TextStyle(color: Theme.of(context).primaryColor),
      ),
      child: Text('COMPRAR'),
    );
  }
}
