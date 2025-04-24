import 'package:flutter/material.dart';
import 'package:shopapp/models/cart_item.dart';

class CartComponent extends StatelessWidget {
  final CartItem cartItem;

  const CartComponent(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 5 
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(child: Text('${cartItem.price}')),
            ),
          ),
          title: Text(cartItem.name),
          subtitle: Text('Total: R\$${cartItem.price * cartItem.quantify}'),
          trailing: Text(
            '${cartItem.quantify}x',
            style: TextStyle(
              fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}
