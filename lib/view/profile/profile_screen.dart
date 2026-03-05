import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webean/model/profile_model.dart';
import 'package:webean/route/app_route.dart';
import 'package:webean/service/auth_service.dart';
import 'package:webean/service/imagekit_service.dart';
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

  final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImage() async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

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

  bool isLoading = false;

  Future<void> verify() async {
    final token = await SecureStorage.getToken();
    setState(() => isLoading = true);

    try {
      if (token != null) {
        await AuthService.verify(token: token);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verifikasi berhasil! Silakan coba lagi.'),
          ),
        );
        setState(() {
          profileFuture = _loadProfile();
        });
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
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
              final errorMsg = snapshot.error.toString().replaceFirst(
                'Exception: ',
                '',
              );
              final isVerifyError = errorMsg.toLowerCase().contains('verif');
              return Center(
                child: Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        errorMsg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 24),
                      if (isVerifyError)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.verified_user_outlined),
                            label: const Text("Verifikasi Akun"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF235347),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: isLoading ? null : () => verify(),
                          ),
                        ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            profileFuture = _loadProfile();
                          });
                        },
                        child: const Text(
                          'Try Again',
                          style: TextStyle(
                            color: Color(0xFF0B2B26),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
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
                        color: Color(0xFF0B2B26),
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
                                color: Color(0xFF235347),
                                shape: BoxShape.circle,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      try {
                                        final file = await pickImage();
                                        if (file == null) return;

                                        final imageUrl = await ImagekitService()
                                            .uploadImageKit(file);

                                        if (imageUrl.isEmpty) {
                                          throw Exception("gambar kosong");
                                        }

                                        await ImagekitService().saveImageUrl(
                                          imageUrl,
                                        );

                                        setState(() {
                                          profileFuture = _loadProfile();
                                        });
                                      } catch (e, s) {
                                        debugPrint('UPLOAD ERROR: $e');
                                        debugPrintStack(stackTrace: s);
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 110,
                                      backgroundColor: const Color(0xFF5E936C),
                                      backgroundImage:
                                          (profile.imageProfile != null &&
                                              profile.imageProfile!.isNotEmpty)
                                          ? NetworkImage(profile.imageProfile!)
                                          : null,
                                      child:
                                          (profile.imageProfile == null ||
                                              profile.imageProfile!.isEmpty)
                                          ? const Icon(
                                              Icons.person,
                                              size: 80,
                                              color: Colors.white,
                                            )
                                          : null,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    right: 12,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.camera_alt,
                                        color: Colors.white,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ],
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
                        ProfileCard(profile: profile),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.logout),
                            label: const Text("Logout"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF235347),
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              await SecureStorage.logout();
                              Get.offAllNamed(AppRoute.login);
                            },
                          ),
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
