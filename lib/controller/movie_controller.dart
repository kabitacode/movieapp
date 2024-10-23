import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieapp/models/genre_model.dart';
import 'package:movieapp/models/movie_model.dart';

class MovieController extends GetxController {
  var isLoading = true.obs;
  var loadingGenre = false.obs;
  var list = [].obs;
  var page = 1;
  String? api_key = dotenv.env['API_KEY'];
  var accessToken = dotenv.env['ACCESS_TOKEN'];

  int? selectedGenre;
  final movieList = <MovieModel>[].obs;
  final genreList = <Genres>[].obs;

  @override
  void onInit() {
    super.onInit();
    getMovies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getMovies({int? page, int? genre}) async {
    isLoading.value = true;

    final String baseUrl = genre != null
        ? "https://api.themoviedb.org/3/discover/movie?api_key=$api_key&page=${page ?? this.page}&with_genres=$genre"
        : "https://api.themoviedb.org/3/discover/movie?api_key=$api_key&page=${page ?? this.page}";

    try {
      final res = await http.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
      });
      var result = json.decode(res.body);

      print(result);
      print(res.request);

      if (res.statusCode == 200) {
        if (page == 1) {
          movieList.value = List.from(
            result['results'].map((el) => MovieModel.fromJson(el)),
          );
        } else {
          movieList.addAll(List.from(
            result['results'].map((el) => MovieModel.fromJson(el)),
          ));
        }
        this.page++;
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

  void getGenre() async {
    loadingGenre.value = true;

    final String baseUrl =
        'https://api.themoviedb.org/3/genre/movie/list?language=en';

    try {
      final res = await http.get(Uri.parse(baseUrl), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      });
      var result = json.decode(res.body);

      if (res.statusCode == 200) {
        genreList.value = List<Genres>.from(
            result['genres'].map((el) => Genres.fromJson(el)));
      } else {
        Get.snackbar('error', 'Oops something error!');
      }
    } catch (e) {
      Get.snackbar('error', 'Failed: $e');
      print(e);
    } finally {
      loadingGenre.value = false;
    }
  }
}
