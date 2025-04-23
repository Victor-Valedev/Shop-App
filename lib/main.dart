import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(
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
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


