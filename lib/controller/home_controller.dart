import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapp/bindings/Trending_Bindings.dart';
import 'package:movieapp/bindings/Tv_Bindings.dart';
import 'package:movieapp/bindings/favorite_bindings.dart';
import 'package:movieapp/bindings/movie_bindings.dart';
import 'package:movieapp/bindings/profile_bindings.dart';
import 'package:movieapp/bindings/search_bindings.dart';
import 'package:movieapp/bindings/watchlist_bindings.dart';
import 'package:movieapp/screens/favorite/Favorite_Screen.dart';
import 'package:movieapp/screens/movie/Movie_Screens.dart';
import 'package:movieapp/screens/profile/Profile_Screens.dart';
import 'package:movieapp/screens/search/Search_Screens.dart';
import 'package:movieapp/screens/trending/Trending_Screen.dart';
import 'package:movieapp/screens/tv/Tv_Screen.dart';
import 'package:movieapp/screens/watchlist/Watchlist_Screen.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var tabIndex = 0.obs;

  final pages = <String>[
    '/movie',
    '/trending',
    '/tv',
    '/search',
    '/profile',
    '/favorite',
    '/favorite-tv',
    '/watchlist',
    '/watchlist-tv',
  ];

  void changeTabIndex(int idx) {
    tabIndex.value = idx;
    Get.toNamed(pages[idx], id: 1);
  }

  @override
  void onInit() {
    super.onInit();
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/movie') {
      return GetPageRoute(
          settings: settings,
          page: () => MovieScreens(),
          binding: MovieBindings());
    }

    if (settings.name == '/trending') {
      return GetPageRoute(
          settings: settings,
          page: () => TrendingScreen(),
          binding: TrendingBindings());
    }

    if (settings.name == '/tv') {
      return GetPageRoute(
          settings: settings, page: () => TvScreen(), binding: TvBindings());
    }

    if (settings.name == '/search') {
      return GetPageRoute(
          settings: settings,
          page: () => SearchScreens(),
          binding: SearchBindings());
    }

    if (settings.name == '/profile') {
      return GetPageRoute(
          settings: settings,
          page: () => ProfileScreen(),
          binding: ProfileBindings());
    }

    if (settings.name == '/favorite') {
      return GetPageRoute(
          settings: settings,
          page: () => FavoriteScreen(),
          binding: FavoriteBindings());
    }

    if (settings.name == '/watchlist') {
      return GetPageRoute(
          settings: settings,
          page: () => WatchlistScreen(),
          binding: WatchlistBindings());
    }

    return null;
  }
}
