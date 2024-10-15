import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  var data = {}.obs;
  var isLoading = true.obs;
  String? access_token = dotenv.env['ACCESS_TOKEN'];

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
    const String url = 'https://api.themoviedb.org/3/account/2155979';
    try {
      final res = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access_token'
      });

      final result = json.decode(res.body);

      if (res.statusCode == 200) {
        data.assignAll(result);
      } else {
        Get.snackbar(
            'error', 'Oops something error ${result['status_message'] ?? ''}');
      }
    } catch (e) {
      print(e);
      Get.snackbar('error', 'Oops something error => $e');
    } finally {
      isLoading.value = false;
    }
  }
}
