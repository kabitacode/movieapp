import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:movieapp/screens/home/Home_Screens.dart';
import 'package:movieapp/screens/main/Main_Screens.dart';
// import 'package:movieapp/screens/login/login.dart';
// import 'package:movieapp/screens/movie/Movie_Screen.dart';
import 'package:movieapp/screens/trending/Trending_Screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainScreens()),
        GetPage(name: '/home', page: () => HomeScreens()),
        GetPage(name: '/trending', page: () => TrendingScreen())
      ],
    );
  }
}
