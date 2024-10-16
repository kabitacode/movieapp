import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/controller/detail_controller.dart';

class FavoriteController extends GetxController {
  String? access_token = dotenv.env['ACCESS_TOKEN'];
  var account_id = dotenv.env['ACCOUNT_ID'];
  var isLoading = true.obs;
  var data = {}.obs;
  var watchList = {}.obs;

  final int movieId;
  FavoriteController({required this.movieId});

  @override
  void onInit() {
    super.onInit();
  }

  void addToFavorites(bool isFavorite) async {
    var url = 'https://api.themoviedb.org/3/account/$account_id/favorite';
    try {
      isLoading.value = true;
      final res = await http.post(Uri.parse(url),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $access_token'
          },
          body: jsonEncode({
            'media_type': 'movie',
            'media_id': movieId,
            'favorite': isFavorite
          }));

      final result = json.decode(res.body);

      if (res.statusCode == 201) {
        data.assignAll(result);
        Get.snackbar('success', 'Added to Favorites');
      }

      if (res.statusCode == 200) {
        data.assignAll(result);
        Get.snackbar(
            'success', result['status_message'] ?? "Remove from Favorites");
      }
    } catch (e) {
      Get.snackbar('error', 'Oops : $e');
    } finally {
      isLoading.value = false;
    }
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
