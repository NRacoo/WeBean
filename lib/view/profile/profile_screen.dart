import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:webean/model/profile_model.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/service/profile_service.dart';
import 'package:webean/utils/secure_storage.dart';
import 'package:webean/widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileModel> profileFuture;

  @override
  void initState() {
    super.initState();
    profileFuture = _loadProfile();
  }

  Future<ProfileModel> _loadProfile() async {
    final token = await SecureStorage.getToken();
    final username = await SecureStorage.getUsername();

    if (token == null || username == null) {
      throw Exception('Login');
    }

    return ProfileService().getProfile(token: token, username: username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: FutureBuilder<ProfileModel>(
          future: profileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            final profile = snapshot.data!;

            return Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Color(0xFF3E5F44),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(200),
                          bottomRight: Radius.circular(200),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFF5E936C),
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: 110,
                                backgroundColor: const Color(0xFF5E936C),
                                backgroundImage: profile.imageProfile != null
                                    ? NetworkImage(profile.imageProfile!)
                                    : null,
                                child: profile.imageProfile == null
                                    ? const Icon(
                                        Icons.person,
                                        size: 80,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            profile.username.split('.').first,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ProfileCard(),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          label: const Text("Logout"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF5E936C),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            await SecureStorage.logout();
                            Get.offAllNamed(AppRoute.login);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
