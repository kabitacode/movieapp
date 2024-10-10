import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/controller/main_controller.dart';

class HomeController extends GetxController {
  var isLoading = true.obs;
  var list = [].obs;

  @override
  void onInit() {
    super.onInit();
    getMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getMovies() async {
    isLoading.value = true;

    final String baseUrl =
        "https://api.themoviedb.org/3/discover/movie?api_key=$API_KEY";

    try {
      final res = await http.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
        // "Authorization":
        //     'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYWMzODcwMzRhNDA5OTA1YjgxMTg1MDdkMzhkYTU5MyIsIm5iZiI6MTcyODQ0MTA3OS40ODEwMjUsInN1YiI6IjY3MDRlNGFkNGIwYzViOWQ3MTY5Yzk4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nFpg8WE3KBIwywq197_baJqKevk46HhrVNiFqq2_gMs'
      });
      var result = json.decode(res.body);

      if (res.statusCode == 200) {
        list.value = result['results'];
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
