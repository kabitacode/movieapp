import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/movie_controller.dart';
import 'package:movieapp/controller/playingList_controller.dart';
import 'package:movieapp/screens/detail/Detail_Screen.dart';
import 'package:movieapp/utils/theme.dart';

class MovieScreens extends StatefulWidget {
  const MovieScreens({super.key});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreens> {
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
        controller.getMovies(page: controller.page);
      }
    });
    playingListController.getApi(page: 1);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
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
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         "Now Playing",
                    //         style: GoogleFonts.openSans(
                    //           color: Colors.white,
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //       InkWell(
                    //         onTap: () {},
                    //         child: Container(
                    //           child: Row(
                    //             crossAxisAlignment: CrossAxisAlignment.center,
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 'Get Detail',
                    //                 style: GoogleFonts.openSans(
                    //                   color: Colors.white,
                    //                   fontSize: 15,
                    //                   fontWeight: FontWeight.w700,
                    //                 ),
                    //               ),
                    //               SizedBox(
                    //                 width: 5,
                    //               ),
                    //               Icon(
                    //                 Icons.arrow_forward_ios,
                    //                 color: Colors.white,
                    //                 size: 15,
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
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
