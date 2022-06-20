import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_overview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SHOP APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.deepOrange),
        fontFamily: 'Lato',
      ),
      debugShowCheckedModeBanner: false,
      home: ProductOverviewScreen(),
    );
  }
}
