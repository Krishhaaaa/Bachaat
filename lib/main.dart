import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/auth_provider.dart';
import 'providers/comparison_provider.dart';

import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/main_navigation_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Authentication state
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),

        // Price comparison state
        ChangeNotifierProvider(
          create: (_) => ComparisonProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Bachat - Smart Price Comparison",

        // App Theme
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),

        // First screen
        home: MainNavigationScreen(),


        // Routes
        routes: {
          "/login": (context) => LoginScreen(),
          "/home": (context) => const HomeScreen(),
        },
      ),
    );
  }
}
