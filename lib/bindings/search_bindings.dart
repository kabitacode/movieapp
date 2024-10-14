import 'package:get/get.dart';
import 'package:movieapp/controller/search_controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchControllers());
  }
}
