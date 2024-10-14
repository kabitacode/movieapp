import 'package:get/get.dart';
import 'package:movieapp/controller/movie_controller.dart';

class MovieBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MovieController());
  }
}
