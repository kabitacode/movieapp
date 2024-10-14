import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/detail_controller.dart';
import 'package:movieapp/controller/movie_controller.dart';
import 'package:movieapp/utils/theme.dart';

class DetailScreen extends StatefulWidget {
  final int movieId;

  const DetailScreen({required this.movieId});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late DetailController detailController;

  @override
  void initState() {
    super.initState();
    detailController = Get.put(DetailController(movieId: widget.movieId));
  }

  @override
  Widget build(BuildContext context) {
    final movie = detailController.list;

    return Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(() {
          if (detailController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
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
                    Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        detailController.list['title'],
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                    if (movie['genres'] != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 15,
                          children:
                              List.generate(movie['genres'].length, (index) {
                            return Expanded(
                              child: Container(
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
                                detailController.list['release_date'],
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
                              detailController.list['status'],
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
