import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/controller/profile_controller.dart';
import 'package:movieapp/utils/theme.dart';
import 'package:movieapp/widgets/Button_Profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = Get.put(ProfileController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: Obx(() {
          if (_profileController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            String path =
                _profileController.data['avatar']?['tmdb']?['avatar_path'];
            String image =
                path != null ? 'https://image.tmdb.org/t/p/w500$path' : '';

            return SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            image,
                            width: 100.0,
                            height: 100.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        _profileController.data['name'] ??
                            _profileController.data['username'],
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ButtonProfile(
                            title: 'Favorite Movies',
                            icon: Icons.favorite,
                            onTap: () => Get.toNamed('/favorite')),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ButtonProfile(
                              title: 'Favorite TV',
                              icon: Icons.tv,
                              onTap: () => Get.toNamed('/favorite-tv'))),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: ButtonProfile(
                            title: 'Top Rated',
                            icon: Icons.stars,
                            onTap: () => Get.toNamed('rated')),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ButtonProfile(
                              title: 'Watchlist Movie',
                              icon: Icons.movie,
                              onTap: () {
                                Get.toNamed('/watchlist');
                              })),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ButtonProfile(
                              title: 'Watchlist TV',
                              icon: Icons.tv,
                              onTap: () {
                                Get.toNamed('/watchlist-tv');
                              })),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ButtonProfile(
                              title: 'Playing List',
                              icon: Icons.list_alt_outlined,
                              onTap: () {
                                Get.toNamed('/playinglist');
                              })),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: ButtonProfile(
                              title: 'Popular',
                              icon: Icons.list_alt_outlined,
                              onTap: () {
                                Get.toNamed('/popular');
                              })),
                    ],
                  )),
            ));
          }
        }));
  }
}
