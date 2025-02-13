import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/movie_controller.dart';
import 'package:movieapp/controller/playingList_controller.dart';
import 'package:movieapp/screens/detail/Detail_Screen.dart';
import 'package:movieapp/utils/theme.dart';
import 'package:movieapp/widgets/Button_Profile.dart';

class MovieScreens extends StatefulWidget {
  const MovieScreens({super.key});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreens> {
  int? selectedGenre;
  final MovieController controller = Get.put(MovieController());
  final PlayingListController playingListController =
      Get.put(PlayingListController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.getMovies(page: controller.page, genre: selectedGenre);
      }
    });
    playingListController.getApi(page: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void openModal() {
    Get.bottomSheet(Obx(() {
      if (controller.loadingGenre.value) {
        return Container(
          color: AppColors.background,
          height: 200,
          child: CircularProgressIndicator(),
        );
      }

      return Container(
        decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                "Genre Movie",
                textAlign: TextAlign.center,
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        controller.getMovies(page: 1);
                        Get.back();
                      },
                      child: Text(
                        "All",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: controller.genreList.length,
                  itemBuilder: (context, index) {
                    final genre = controller.genreList[index];
                    return ListTile(
                      title: Text(
                        genre.name,
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          selectedGenre = genre.id;
                        });
                        controller.getMovies(genre: selectedGenre, page: 1);
                        Get.back();
                      },
                    );
                  }),
            ),
          ],
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(() {
          if (controller.isLoading.value && controller.movieList.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Home",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Genre",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              controller.getGenre();
                              openModal();
                            },
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Get Detail',
                                    style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.7),
                          itemCount: controller.movieList.length,
                          itemBuilder: (context, index) {
                            final item = controller.movieList[index];

                            return InkWell(
                                onTap: () {
                                  Get.to(() =>
                                      DetailScreen(movieId: item.id ?? 0));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          child: item.posterPath != null
                                              ? Image.network(
                                                  width: double.infinity,
                                                  'https://image.tmdb.org/t/p/w500${item.posterPath}',
                                                  fit: BoxFit.cover,
                                                )
                                              : Icon(
                                                  Icons.image_not_supported,
                                                  size: 50,
                                                )),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Center(
                                        child: Text(
                                          item.title ?? 'No Title Available',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColors.typography,
                                              fontWeight: FontWeight.w600),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Center(
                                        child: Text(
                                          item.title ?? 'No Subtitle Available',
                                          style: TextStyle(fontSize: 10),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          }),
                    ),
                    if (controller.isLoading.value)
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator())
                  ],
                ),
              ),
            );
          }
        }));
  }
}
