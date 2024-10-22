import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/popular_controller.dart';
import 'package:movieapp/screens/detail/Detail_Screen.dart';
import 'package:movieapp/utils/theme.dart';
import 'package:movieapp/widgets/Button_Back.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  final PopularController controller = Get.put(PopularController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.getApi(page: controller.page);
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
                child: Stack(
              children: [
                SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 120),
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                    () => DetailScreen(movieId: item.id ?? 0));
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        item.subtitle ??
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
                ),
                if (controller.isLoading.value)
                  Positioned(
                      top: 150,
                      left: 50,
                      right: 50,
                      child: Container(
                        width: 250,
                        height: 250,
                        color: AppColors.background,
                        child: const Padding(
                            padding: EdgeInsets.all(10),
                            child: CircularProgressIndicator()),
                      )),
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: AppColors.background,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          Container(
                            child: ButtonBack(onTap: () => Get.back()),
                          ),
                          Text(
                            "Popular",
                            style: GoogleFonts.openSans(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "List of good popular movies",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ));
          }
        }));
  }
}
