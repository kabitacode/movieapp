import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/search_controller.dart';
import 'package:movieapp/screens/detail/Detail_Screen.dart';
import 'package:movieapp/utils/theme.dart';

class SearchScreens extends StatefulWidget {
  const SearchScreens({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreens> {
  final SearchControllers controller = Get.put(SearchControllers());
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.getMovies(page: controller.page);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _textEditingController.dispose();
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
                    Text(
                      "Search",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                              hintText: 'Search..',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (_textEditingController.text.isEmpty) {
                                      controller.getMovies(page: 1);
                                    } else {
                                      controller.searchApi(
                                          _textEditingController.text);
                                    }
                                  },
                                  icon: Icon(Icons.search))),
                          onChanged: (val) {
                            if (val.isEmpty) {
                              controller.getMovies(page: 1);
                            }
                          },
                          onSubmitted: (query) {
                            if (_textEditingController.text.isEmpty) {
                              controller.getMovies(page: 1);
                            } else {
                              controller.searchApi(query);
                            }
                          }),
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
