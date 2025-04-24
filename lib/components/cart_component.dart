import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/cart_item.dart';

class CartComponent extends StatelessWidget {
  final CartItem cartItem;

  const CartComponent(this.cartItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.only(left: 20),
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 5 
        ),
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(
          context, 
          listen: false,
        ).removeItem(cartItem.productId);
      },
      child: Card(
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
      ),
    );
  }
}
