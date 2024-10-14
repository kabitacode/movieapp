import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/controller/main_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var list = [].obs;
  var page = 1;
  String? api_key = dotenv.env['API_KEY'];

  @override
  void onInit() {
    super.onInit();
    getMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getMovies({int? page}) async {
    isLoading.value = true;

    final String baseUrl =
        "https://api.themoviedb.org/3/discover/movie?api_key=$api_key&page=${page ?? this.page}";

    try {
      final res = await http.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
      });
      var result = json.decode(res.body);

      if (res.statusCode == 200) {
        if (page == 1) {
          list.value = result['results'];
        } else {
          list.addAll(result['results']);
        }
        this.page++;
      } else {
        Get.snackbar('error', 'Oops something error!');
      }
    } catch (e) {
      Get.snackbar('error', 'Failed: $e');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
