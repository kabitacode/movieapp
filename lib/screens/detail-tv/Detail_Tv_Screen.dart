import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/detail_controller.dart';
import 'package:movieapp/controller/detail_tv_controller.dart';
import 'package:movieapp/controller/favorite_controller.dart';
import 'package:movieapp/controller/watchlist_controller.dart';
import 'package:movieapp/utils/theme.dart';

class DetailTvScreen extends StatefulWidget {
  final int movieId;

  const DetailTvScreen({required this.movieId});

  @override
  _DetailTvScreenState createState() => _DetailTvScreenState();
}

class _DetailTvScreenState extends State<DetailTvScreen> {
  late DetailTvController detailController;
  late FavoriteController favoriteController;
  late WatchlistController watchlistController;
  var isFavorite = false;
  var isWatchList = false;

  @override
  void initState() {
    super.initState();
    detailController = Get.put(DetailTvController(movieId: widget.movieId));
    favoriteController = Get.put(FavoriteController(movieId: widget.movieId));
    watchlistController = Get.put(WatchlistController(movieId: widget.movieId));
  }

  void postFavorite() {
    Get.put(FavoriteController(movieId: detailController.movieId));
    final controller = Get.find<FavoriteController>();
    controller.addToFavorites(!isFavorite);
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void postWatchList() {
    Get.put(WatchlistController(movieId: detailController.movieId));
    final watchController = Get.find<WatchlistController>();
    watchController.addToWatchlist(!isWatchList);
    setState(() {
      isWatchList = !isWatchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movie = detailController.list;

    return Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(() {
          if (detailController.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(
                              size: 15,
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                            Text(
                              "Back",
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        detailController.list['title'] ??
                            detailController.list['name'] ??
                            'Title Not Available',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: detailController.list['poster_path'] != null
                            ? Image.network(
                                height: 300,
                                'https://image.tmdb.org/t/p/w500${detailController.list['poster_path']}',
                                fit: BoxFit.fitWidth,
                              )
                            : Icon(
                                Icons.image_not_supported,
                                size: 50,
                              )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () => postWatchList(),
                                child: FittedBox(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Add to Watchlist',
                                        style: GoogleFonts.openSans(
                                          color: AppColors.typography,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.live_tv_rounded,
                                      color: isWatchList
                                          ? Colors.lightBlueAccent
                                          : AppColors.typography,
                                    ),
                                    if (watchlistController.isLoading.value)
                                      CircularProgressIndicator()
                                  ],
                                ))),
                          ),
                          SizedBox(width: 20),
                          Flexible(
                            child: ElevatedButton(
                                onPressed: () => postFavorite(),
                                child: FittedBox(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Add to Favorite',
                                        style: GoogleFonts.openSans(
                                          color: AppColors.typography,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.favorite,
                                      color: isFavorite
                                          ? Colors.red
                                          : AppColors.typography,
                                    ),
                                    if (favoriteController.isLoading.value)
                                      CircularProgressIndicator()
                                  ],
                                ))),
                          )
                        ],
                      ),
                    ),
                    if (movie['genres'] != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 15,
                          children:
                              List.generate(movie['genres'].length, (index) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              decoration: BoxDecoration(
                                  color: AppColors.other1,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Text(
                                textAlign: TextAlign.center,
                                movie['genres'][index]['name'],
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                'Release Date : ',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                detailController.list['release_date'] ?? '-',
                                style: GoogleFonts.openSans(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 4),
                            decoration: BoxDecoration(
                                color: AppColors.orange,
                                borderRadius: BorderRadius.circular(25)),
                            child: Text(
                              textAlign: TextAlign.center,
                              detailController.list['status'] ?? '-',
                              style: GoogleFonts.openSans(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        textAlign: TextAlign.center,
                        detailController.list['overview'],
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
          }
        }));
  }
}
