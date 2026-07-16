import 'package:flutter/material.dart';
import 'features/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Package of the Day',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4F46E5)),
        useMaterial3: false,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4F46E5), // Indigo
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      // home: const Day01AvatarGlow(),
      home: const Day02GoogleFonts(),
    );
  }
}
