import 'package:get/get.dart';
import 'package:movieapp/controller/popular_controller.dart';

class PopularBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PopularController());
  }
}
