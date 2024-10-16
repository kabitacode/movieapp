import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WatchlistController extends GetxController {
  String? access_token = dotenv.env['ACCESS_TOKEN'];
  var account_id = dotenv.env['ACCOUNT_ID'];
  var isLoading = false.obs;
  var data = {}.obs;

  final int movieId;
  WatchlistController({required this.movieId});

  @override
  void onInit() {
    super.onInit();
  }

  void addToWatchlist(bool isWatchlist) async {
    var url = 'https://api.themoviedb.org/3/account/$account_id/watchlist';

    try {
      final res = await http.post(Uri.parse(url),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $access_token'
          },
          body: jsonEncode({
            'media_type': 'movie',
            'media_id': movieId,
            'watchlist': isWatchlist
          }));

      final result = await json.decode(res.body);
      if (res.statusCode == 201) {
        data.assignAll(result);
        Get.snackbar('success', 'Added to Watchlist');
      }

      if (res.statusCode == 200) {
        data.assignAll(result);
        Get.snackbar(
            'success', result['status_message'] ?? "Remove from Watchlist");
      }
    } catch (e) {
      Get.snackbar('error', 'Oops something Error : $e');
    }
  }
}
