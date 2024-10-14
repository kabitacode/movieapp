import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controller/main_controller.dart';
import 'package:movieapp/screens/home/Home_Screens.dart';
import 'package:movieapp/screens/trending/Trending_Screen.dart';
import 'package:movieapp/screens/tv/Tv_Screen.dart';
import 'package:movieapp/utils/theme.dart';

class MainScreens extends StatelessWidget {
  final MainController homeController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() => IndexedStack(
            index: homeController.tabIndex.value,
            children: [HomeScreens(), TrendingScreen(), TvScreen()],
          )),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: homeController.tabIndex.value,
          onTap: homeController.changeTabIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.ac_unit_sharp), label: "Trending"),
            BottomNavigationBarItem(icon: Icon(Icons.tv_rounded), label: "TV")
          ],
        );
      }),
    );
  }
}
