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
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit_sharp), label: "Trending"),
              BottomNavigationBarItem(icon: Icon(Icons.tv_rounded), label: "TV")
            ],
            currentIndex: controller.tabIndex.value,
            selectedItemColor: AppColors.orange,
            onTap: controller.changeTabIndex,
          )),
    );
  }
}
