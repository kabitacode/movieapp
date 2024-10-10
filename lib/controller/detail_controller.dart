import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailController extends GetxController {
  var isLoading = true.obs;
  var list = {}.obs;

  final int movieId;
  DetailController({required this.movieId});

  @override
  void onInit() {
    super.onInit();
    getDetail();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getDetail() async {
    isLoading.value = true;

    final String baseUrl =
        "https://api.themoviedb.org/3/movie/$movieId?api_key=$API_KEY";

    try {
      final res = await http.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
        // "Authorization":
        //     'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYWMzODcwMzRhNDA5OTA1YjgxMTg1MDdkMzhkYTU5MyIsIm5iZiI6MTcyODQ0MTA3OS40ODEwMjUsInN1YiI6IjY3MDRlNGFkNGIwYzViOWQ3MTY5Yzk4MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.nFpg8WE3KBIwywq197_baJqKevk46HhrVNiFqq2_gMs'
      });
      var result = json.decode(res.body);

      if (res.statusCode == 200) {
        list.value = result;
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
