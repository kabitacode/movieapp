import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TvController extends GetxController {
  var list = [].obs;
  var isLoading = true.obs;
  String? api_key = dotenv.env['API_KEY'];

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getApi() async {
    isLoading.value = true;

    final String baseUrl =
        "https://api.themoviedb.org/3/discover/tv?api_key=${api_key}&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false";

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
