import 'package:get/get.dart';
import 'package:movieapp/controller/tv_controller.dart';

class TvBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TvController());
  }
}
