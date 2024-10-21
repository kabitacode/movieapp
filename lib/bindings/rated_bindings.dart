import 'package:get/get.dart';
import 'package:movieapp/controller/rated_controller.dart';

class RatedBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RatedController());
  }
}
