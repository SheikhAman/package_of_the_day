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
      // home: const Day02GoogleFonts(),
      // home: const Day03LiquidPullToRefresh(),
      // home: const Day04PercentIndicator(),
      // home: const Day05FlutterCarouselSlider(),
      // home: const Day06SmoothPageIndicator(),
      // home: const Day07FontAwesomeFlutter(),
      // home: const Day08Animations(),
      // home: const Day09Neon(),
      // home: const Day10Aurora(),
      // home: const Day11CardSwiper(),
      // home: const Day12FlutterBlurHash(),
      // home: const Day13FlutterSvg(),
      // home: const Day14FlutterCustomClippers(),
      // home: const Day15FlutterTts(),
      // home: const Day16FlutterHighlight(),
      // home: const Day17SyncfusionFlutterCharts(),
      // home: const Day18RflutterAlert(),
      // home: const Day19FlutterSettingsUi(),
      // home: const Day20FlutterSpinkit(),
      // home: const Day21AudioPlayers(),
      // home: const Day22GoRouter(),
      // home: const Day23Http(),
      // home: const Day24Onboarding(),
      // home: const Day25FlutterNeumorphicPlus(),
      // home: const Day26MathExpressions(),
      // home: const Day27ClayContainers(),
      // home: const Day28DayNightSwitch(),
      // home: const Day29Provider(),
      // home: const Day30FlutterLucide(),
      // home: const Day31SimpleGradientText(),
      // home: const Day32ImagePicker(),
      // home: const Day33CurvedLabeledNavBar(),
      // home: const Day34IntroSlider(),
      home: const Day35PhosphorFlutterIcons(),
    );
  }
}
