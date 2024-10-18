import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WatchlistScreenController extends GetxController {
  var isLoading = false.obs;
  var list = [].obs;
  String? api_key = dotenv.env['API_KEY'];
  var account_id = dotenv.env['ACCOUNT_ID'];
  String? access_token = dotenv.env['ACCESS_TOKEN'];
  var page = 1;

  final String selectwatchlist;
  WatchlistScreenController({required this.selectwatchlist});

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getApi({int? page}) async {
    final String endpoint = selectwatchlist == 'movie' ? 'movies' : 'tv';
    var url =
        'https://api.themoviedb.org/3/account/$account_id/watchlist/$endpoint?language=en-US&page=${page ?? this.page}';

    try {
      isLoading.value = true;
      final res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token'
      });
      final result = await json.decode(res.body);
      if (res.statusCode == 200) {
        if (page == 1) {
          list.value = result['results'];
        } else {
          list.addAll(result['results']);
        }
      } else {
        Get.snackbar('error', 'Oops something error!');
      }
    } catch (e) {
      Get.snackbar('error', 'Failed: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
