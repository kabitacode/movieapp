import 'package:get/get.dart';
import 'package:movieapp/controller/watchlist_screen_controller.dart';

class WatchlistBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WatchlistScreenController());
  }
}
