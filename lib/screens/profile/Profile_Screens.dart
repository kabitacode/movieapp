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
                      ButtonProfile(
                          title: 'Favorite',
                          icon: Icons.favorite,
                          onTap: () => Get.toNamed('/favorite')),
                      ButtonProfile(
                          title: 'Rated', icon: Icons.stars, onTap: () {}),
                      ButtonProfile(
                          title: 'Watchlist', icon: Icons.tv, onTap: () {})
                    ],
                  )),
            ));
          }
        }));
  }
}
