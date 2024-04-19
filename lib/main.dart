import 'package:flutter/material.dart';
import 'package:flutter_fake_store_api/controller/cart_controller.dart';
import 'package:flutter_fake_store_api/controller/home_screen_controller.dart';
import 'package:flutter_fake_store_api/view/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider<HomeScreenController>(
          create: (context) => HomeScreenController(),
        ),
        ChangeNotifierProvider<CartController>(
          create: (context) => CartController(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 240, 240, 240),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
