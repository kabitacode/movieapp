import 'package:get/get.dart';
import 'package:movieapp/controller/detail_controller.dart';

class DetailBindings extends Bindings {
  final DetailController _controller = Get.find<DetailController>();

  @override
  void dependencies() {
    Get.lazyPut(() => DetailController(movieId: _controller.movieId));
  }
}
