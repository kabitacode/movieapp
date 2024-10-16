import 'package:get/get.dart';
import 'package:movieapp/controller/favorite_screen_controller.dart';

class FavoriteBindings extends Bindings {
  final String selectFavorite;
  FavoriteBindings({required this.selectFavorite});

  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteScreenController(selectFavorite: selectFavorite));
  }
}
