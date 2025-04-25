import 'package:flutter/material.dart';
import 'package:shopapp/models/product.dart';

class ProductItemManager extends StatelessWidget {
  final Product product;

  const ProductItemManager(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.edit)
            ),
            IconButton(
              onPressed: (){},
              icon: Icon(Icons.delete)
            )
          ],
        ),
      ),
    );
  }
}
