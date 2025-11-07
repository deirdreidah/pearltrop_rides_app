import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash_screen.dart'; // Importing my splash screen


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Make the status bar transparent (looks nicer)
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  
  runApp(const MyRideApp());
}

// This is my main app widget
class MyRideApp extends StatelessWidget {
  const MyRideApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PearlTrop Rides',
      debugShowCheckedModeBanner: false, //This removes the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Splash screen is my first screen!
      home: const SplashScreen(),
    );
  }
}