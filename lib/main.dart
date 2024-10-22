import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
// import 'package:movieapp/bindings/detail_bindings.dart';
import 'package:movieapp/bindings/favorite_bindings.dart';
import 'package:movieapp/bindings/home_bindings.dart';
import 'package:movieapp/bindings/playingList_bindings.dart';
import 'package:movieapp/bindings/popular_bindings.dart';
import 'package:movieapp/bindings/profile_bindings.dart';
import 'package:movieapp/bindings/rated_bindings.dart';
import 'package:movieapp/bindings/search_bindings.dart';
import 'package:movieapp/bindings/trending_bindings.dart';
import 'package:movieapp/bindings/tv_bindings.dart';
import 'package:movieapp/bindings/movie_bindings.dart';
import 'package:movieapp/bindings/upcoming_bindings.dart';
import 'package:movieapp/bindings/watchlist_bindings.dart';
// import 'package:movieapp/screens/detail/Detail_Screen.dart';
import 'package:movieapp/screens/favorite-tv/Favorite_Tv_Screen.dart';
import 'package:movieapp/screens/favorite/Favorite_Screen.dart';
import 'package:movieapp/screens/movie/Movie_Screens.dart';
import 'package:movieapp/screens/home/Home_Screens.dart';
import 'package:movieapp/screens/playing-list/PlayingList_Screen.dart';
import 'package:movieapp/screens/popular/Popular_Screen.dart';
import 'package:movieapp/screens/profile/Profile_Screens.dart';
import 'package:movieapp/screens/rated/Rated_Screen.dart';
import 'package:movieapp/screens/search/Search_Screens.dart';
// import 'package:movieapp/screens/login/login.dart';
// import 'package:movieapp/screens/movie/Movie_Screen.dart';
import 'package:movieapp/screens/trending/Trending_Screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movieapp/screens/tv/Tv_Screen.dart';
import 'package:movieapp/screens/upcoming/Upcoming_Screen.dart';
import 'package:movieapp/screens/watchlist-tv/Watchlist_Tv_Screen.dart';
import 'package:movieapp/screens/watchlist/Watchlist_Screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      defaultTransition: Transition.fade,
      getPages: [
        GetPage(
            name: '/home', page: () => HomeScreens(), binding: HomeBindings()),
        GetPage(
            name: '/movie',
            page: () => MovieScreens(),
            binding: MovieBindings()),
        GetPage(
            name: '/trending',
            page: () => TrendingScreen(),
            binding: TrendingBindings()),
        GetPage(name: '/tv', page: () => TvScreen(), binding: TvBindings()),
        GetPage(
            name: '/search',
            page: () => SearchScreens(),
            binding: SearchBindings()),
        GetPage(
            name: '/profile',
            page: () => ProfileScreen(),
            binding: ProfileBindings()),
        GetPage(
            name: '/favorite',
            page: () => FavoriteScreen(),
            binding: FavoriteBindings(selectFavorite: 'movie')),
        GetPage(
            name: '/favorite-tv',
            page: () => FavoriteTvScreen(),
            binding: FavoriteBindings(selectFavorite: 'tv')),
        GetPage(
            name: '/watchlist',
            page: () => WatchlistScreen(),
            binding: WatchlistBindings(selectWatchlist: 'movie')),
        GetPage(
            name: '/watchlist-tv',
            page: () => WatchlistTvScreen(),
            binding: WatchlistBindings(selectWatchlist: 'tv')),
        GetPage(
            name: '/playinglist',
            page: () => PlayingListScreen(),
            binding: PlayingListBindings()),
        GetPage(
            name: '/rated',
            page: () => RatedScreen(),
            binding: RatedBindings()),
        GetPage(
            name: '/popular',
            page: () => PopularScreen(),
            binding: PopularBindings()),
        GetPage(
            name: '/upcoming',
            page: () => UpcomingScreen(),
            binding: UpcomingBindings()),
        // GetPage(
        //     name: '/detail',
        //     page: () => DetailScreen(),
        //     binding: DetailBindings()),
      ],
    );
  }
}
