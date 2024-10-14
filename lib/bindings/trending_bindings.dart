import 'package:get/get.dart';
import 'package:movieapp/controller/trending_controller.dart';

class TrendingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrendingController());
  }
}
