import 'package:get/get.dart';
import 'package:movieapp/controller/playingList_controller.dart';

class PlayingListBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayingListController());
  }
}
