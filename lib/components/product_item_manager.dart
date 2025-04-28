import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/exceptions/http_exception.dart';
import 'package:shopapp/models/product.dart';
import 'package:shopapp/models/product_list.dart';
import 'package:shopapp/utils/app_routes.dart';

class ProductItemManager extends StatelessWidget {
  final Product product;

  const ProductItemManager(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    final message = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(product.imageUrl)),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).pushNamed(AppRoutes.PRODUCTS_FORM, arguments: product);
              },
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              onPressed: () {
                showDialog<bool>(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: Text('Excluir Produtos'),
                        content: Text('Tem certeza que deseja excluir?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(false),
                            child: Text('Não'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(true),
                            child: Text('Sim'),
                          ),
                        ],
                      ),
                ).then((value) async {
                  if (value ?? false) {
                    try {
                      await Provider.of<ProductList>(
                        context,
                        listen: false,
                      ).removeProduct(product);
                    } on HttpException catch (error) {
                      message.showSnackBar(
                        SnackBar(
                        content: Text(error.toString()),
                       )
                     );
                    }
                  }
                });
              },
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
