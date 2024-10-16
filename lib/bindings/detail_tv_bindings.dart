import 'package:get/get.dart';
import 'package:movieapp/controller/detail_tv_controller.dart';

class DetailTvBindings extends Bindings {
  final DetailTvController _controller = Get.find<DetailTvController>();

  @override
  void dependencies() {
    Get.lazyPut(() => DetailTvController(movieId: _controller.movieId));
  }
}
