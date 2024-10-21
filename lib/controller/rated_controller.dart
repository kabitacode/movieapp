import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:http/http.dart' as http;

class RatedController extends GetxController {
  var isLoading = false.obs;
  var page = 1;
  final accessToken = dotenv.env['ACCESS_TOKEN'];
  final list = <MovieModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  void getApi({int? page}) async {
    final url =
        'https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=${page ?? this.page}';
    try {
      isLoading.value = true;
      final res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });

      final result = await json.decode(res.body);
      if (res.statusCode == 200) {
        if (page == 1) {
          list.value =
              List.from(result['results'].map((el) => MovieModel.fromJson(el)));
        } else {
          list.addAll(List.from(
              result['results'].map((el) => MovieModel.fromJson(el))));
        }
        this.page++;
      } else {
        Get.snackbar('error', 'Oops something error!');
      }
    } catch (e) {
      Get.snackbar('error', 'Error > $e');
    } finally {
      isLoading.value = false;
    }
  }
}
