import 'package:get/get.dart';
import 'package:movieapp/controller/watchlist_screen_controller.dart';

class WatchlistBindings extends Bindings {
  final String selectWatchlist;
  WatchlistBindings({required this.selectWatchlist});

  @override
  void dependencies() {
    Get.lazyPut(
        () => WatchlistScreenController(selectwatchlist: selectWatchlist));
  }
}
