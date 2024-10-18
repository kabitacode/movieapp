import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/favorite_screen_controller.dart';
import 'package:movieapp/screens/detail/Detail_Screen.dart';
import 'package:movieapp/utils/theme.dart';

class FavoriteTvScreen extends StatefulWidget {
  const FavoriteTvScreen({super.key});

  @override
  _FavoriteTvScreenState createState() => _FavoriteTvScreenState();
}

class _FavoriteTvScreenState extends State<FavoriteTvScreen> {
  final FavoriteScreenController controller =
      Get.put(FavoriteScreenController(selectFavorite: 'tv'));
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.fetchFavorite(page: controller.page);
      }
    });
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
          if (controller.isLoading.value && controller.list.isEmpty) {
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
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
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
                    Text(
                      "Favorite Tv",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
                          itemCount: controller.list.length,
                          itemBuilder: (context, index) {
                            final item = controller.list[index];

                            return InkWell(
                                onTap: () {
                                  Get.to(
                                      () => DetailScreen(movieId: item['id']));
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
                                          child: item['poster_path'] != null
                                              ? Image.network(
                                                  width: double.infinity,
                                                  'https://image.tmdb.org/t/p/w500${item['poster_path']}',
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
                                          item['title'] ?? 'No Title Available',
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
                                          item['subtitle'] ??
                                              'No Subtitle Available',
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
