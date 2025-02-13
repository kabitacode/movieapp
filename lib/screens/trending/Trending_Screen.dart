import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/trending_controller.dart';
import 'package:movieapp/screens/detail/Detail_Screen.dart';
import 'package:movieapp/utils/theme.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final TrendingController trendingController = Get.put(TrendingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(() {
          if (trendingController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Trending",
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
                          itemCount: trendingController.list.length,
                          itemBuilder: (context, index) {
                            final item = trendingController.list[index];

                            return InkWell(
                                onTap: () =>
                                    Get.to(DetailScreen(movieId: item['id'])),
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
                  ],
                ),
              ),
            );
          }
        }));
  }
}
