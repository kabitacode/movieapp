import 'package:get/get.dart';

class MainController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int idx) {
    tabIndex.value = idx;
    // switch (idx) {
    //   case 0:
    //     Get.toNamed('/');
    //     break;
    //   case 1:
    //     Get.toNamed('/home');
    //     break;
    //   case 2:
    //     Get.toNamed('/movie');
    //     break;
    //   case 3:
    //     Get.toNamed('/trending');
    //     break;

    //   default:
    // }
  }

  @override
  void onInit() {
    super.onInit();
  }
}
