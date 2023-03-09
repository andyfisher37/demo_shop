import 'package:demo_shop/providers/cart.dart';
import 'package:demo_shop/providers/orders.dart';
import 'package:demo_shop/providers/product.dart';
import 'package:demo_shop/screens/auth_screen.dart';
import 'package:demo_shop/screens/cart_screen.dart';
import 'package:demo_shop/screens/edit_product_screen.dart';
import 'package:demo_shop/screens/orders_screen.dart';
import 'package:demo_shop/screens/product_detail_screen.dart';
import 'package:demo_shop/screens/user_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:demo_shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:demo_shop/providers/products.dart';
import 'package:demo_shop/providers/auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (ctx) => Products('', []),
            update: (ctx, auth, previousProducts) => Products(auth.token!,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders('', []),
            update: (ctx, auth, previousOrders) => Orders(auth.token!,
                previousOrders == null ? [] : previousOrders.orders),
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Demo Shop',
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
                  .copyWith(secondary: Colors.blueGrey),
            ),
            home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
            routes: {
              ProductDetailScreen.routeName: (context) =>
                  const ProductDetailScreen(),
              CartScreen.routeName: (context) => const CartScreen(),
              OrdersScreen.routeName: (context) => const OrdersScreen(),
              UserProductsScreen.routeName: (context) =>
                  const UserProductsScreen(),
              EditProductScreen.routeName: (context) =>
                  const EditProductScreen(),
              AuthScreen.routeName: (context) => AuthScreen(),
            },
          ),
        ));
  }
}
