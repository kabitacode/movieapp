import 'package:get/get.dart';
import 'package:movieapp/controller/favorite_screen_controller.dart';

class FavoriteBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteScreenController());
  }
}
