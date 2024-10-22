import 'package:get/get.dart';
import 'package:movieapp/controller/upcoming_controller.dart';

class UpcomingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpcomingController());
  }
}
