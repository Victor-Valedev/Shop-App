import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/components/app_drawer.dart';
import 'package:shopapp/components/product_item_manager.dart';
import 'package:shopapp/models/product_list.dart';
import 'package:shopapp/utils/app_routes.dart';

class ProducstManagerPage extends StatelessWidget {
  const ProducstManagerPage({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(
      context,
      listen: false,
      ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.PRODUCTS_FORM);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: products.itemsCount,
            itemBuilder:
                (ctx, index) => Column(
                  children: [
                    ProductItemManager(products.items[index]),
                    Divider(color: Colors.grey),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
