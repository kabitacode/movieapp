import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FavoriteScreenController extends GetxController {
  var isLoading = true.obs;
  var list = [].obs;
  var page = 1;
  String? api_key = dotenv.env['API_KEY'];
  var account_id = dotenv.env['ACCOUNT_ID'];
  String? access_token = dotenv.env['ACCESS_TOKEN'];

  final String selectFavorite;
  FavoriteScreenController({required this.selectFavorite});

  @override
  void onInit() {
    super.onInit();
    fetchFavorite(page: 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fetchFavorite({int? page}) async {
    isLoading.value = true;
    final String endpoint = selectFavorite == 'movie' ? 'movies' : 'tv';
    var url =
        'https://api.themoviedb.org/3/account/$account_id/favorite/$endpoint?language=en-US&page=${page ?? this.page}';

    try {
      final res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token'
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
    } finally {
      isLoading.value = false;
    }
  }
}
