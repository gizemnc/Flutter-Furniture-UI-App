import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_furniture_app/pages/start_page.dart';
import 'package:flutter_furniture_app/services/cart_provider.dart';
import 'package:flutter_furniture_app/services/firebase_options.dart'; // Make sure the import is correct
import 'package:flutter_furniture_app/services/locator.dart'; // Make sure the import is correct
import 'package:flutter_furniture_app/viewmodel/user_view_model.dart'; // Make sure the import is correct
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is fully initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Initialize Firebase with platform-specific options
  );
  setUpLocator(); // Set up dependency injection, if applicable

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()), // Provide UserViewModel
        ChangeNotifierProvider(create: (context) => UserViewModel()), // Provide UserViewModel
        // Add other providers here if needed
      ],
      child: const MyApp(), // Run your main app widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Disable the debug banner
      title: 'Furniture UI App',
      theme: ThemeData(
        useMaterial3: false, // Set to true if using Material 3
        primarySwatch: Colors.purple,
      ),
      home: const StartPage(), // Set the home page of the app
    );
  }
}
