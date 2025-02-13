import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TrendingController extends GetxController {
  var isLoading = true.obs;
  var list = [].obs;
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

  void getMovies() async {
    isLoading.value = true;

    final String baseUrl =
        "https://api.themoviedb.org/3/trending/all/day?api_key=$api_key&page=1";

    try {
      final res = await http.get(Uri.parse(baseUrl),
          headers: {'Content-Type': 'application/json'});
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
