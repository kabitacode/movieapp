import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:http/http.dart' as http;

class PlayingListController extends GetxController {
  final isLoading = false.obs;
  final list = <MovieModel>[].obs;
  String? ACCESS_TOKEN = dotenv.env['ACCESS_TOKEN'];
  var page = 1;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  getApi({int? page}) async {
    final url =
        'https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=${page ?? this.page}';

    try {
      final res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $ACCESS_TOKEN'
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
      Get.snackbar('error', 'Oops $e');
    }
  }
}
