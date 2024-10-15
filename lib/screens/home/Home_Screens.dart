import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/controller/home_controller.dart';
import 'package:movieapp/utils/theme.dart';

class HomeScreens extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/movie',
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.movie), label: "Trending"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.tv_rounded), label: "TV"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded), label: "Profile"),
            ],
            backgroundColor: AppColors.background,
            currentIndex: controller.tabIndex.value,
            selectedItemColor: AppColors.orange,
            unselectedItemColor: Colors.white,
            onTap: controller.changeTabIndex,
          )),
    );
  }
}
