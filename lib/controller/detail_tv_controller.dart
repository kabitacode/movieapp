import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DetailTvController extends GetxController {
  var isLoading = true.obs;
  var list = {}.obs;
  String? api_key = dotenv.env['API_KEY'];

  final int movieId;
  DetailTvController({required this.movieId});

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
        "https://api.themoviedb.org/3/tv/$movieId?api_key=$api_key";

    try {
      final res = await http.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
      });
      var result = json.decode(res.body);
      print(res.request);
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
