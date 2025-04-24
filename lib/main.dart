import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/models/cart.dart';
import 'package:shopapp/models/product_list.dart';
import 'package:shopapp/pages/cart_page.dart';
import 'package:shopapp/pages/product_detail_page.dart';
import 'package:shopapp/pages/products_overview_page.dart';
import 'package:shopapp/utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList()
        ),
        ChangeNotifierProvider(
          create: (_) => Cart()
        )
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: Colors.white
            )
          ),
          fontFamily: 'Lato',
          colorScheme: ColorScheme.light(
            primary: Colors.teal,
            secondary: Colors.red,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
          )
        ),
        home: ProductsOverviewPage(),
        routes: {
          AppRoutes.PRODUCT_DETAIL: (ctx) => ProductDetailPage(),
          AppRoutes.CART_SHOP: (ctx) => CartPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}


