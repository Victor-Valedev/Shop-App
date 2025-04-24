import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/badgee.dart';
import 'package:shopapp/components/product_grid.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/utils/app_routes.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {
  ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
                  PopupMenuItem(
                    value: FilterOptions.favorite,
                    child: Text('Somente Favoritos'),
                  ),
                  PopupMenuItem(
                  value: FilterOptions.all, 
                  child: Text('Todos')
                  ),
                ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                    AppRoutes.CART_SHOP
                ),
                icon: Icon(Icons.shopping_cart)
            ),
            builder: (context, cart, child) => Badgee(
              value: cart.itemCount.toString(),
              child: child!,
            ),
          )
        ],
        centerTitle: true,
      ),
      body: ProductGrid(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
