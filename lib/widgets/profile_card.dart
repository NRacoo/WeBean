import 'package:flutter/material.dart';
import 'package:webean/model/profile_model.dart';
import 'package:webean/service/profile_service.dart';
import 'package:webean/utils/secure_storage.dart';

class ProfileCard extends StatefulWidget {
  final ProfileModel profile;

  const ProfileCard({super.key, required this.profile});

  @override
  State<ProfileCard> createState() => _EditProfile();
}

class _EditProfile extends State<ProfileCard> {
  late TextEditingController usernameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;
  late TextEditingController addressC;
  late TextEditingController birthC;
  late ProfileModel initialProfile;

  String formatDate(DateTime? date) {
    if (date == null) return '';

    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    initialProfile = widget.profile;

    usernameC = TextEditingController(text: widget.profile.username);
    emailC = TextEditingController(text: widget.profile.email ?? '');
    phoneC = TextEditingController(text: widget.profile.phone ?? '');
    addressC = TextEditingController(text: widget.profile.address ?? '');
    birthC = TextEditingController(text: formatDate(widget.profile.birth));
  }

  bool isEdit = false;
  bool isLoading = false;

  void _resetForm() {
    usernameC.text = initialProfile.username;
    emailC.text = initialProfile.email ?? '';
    phoneC.text = initialProfile.phone ?? '';
    addressC.text = initialProfile.address ?? '';
    birthC.text = formatDate(initialProfile.birth);
  }

  Map<String, dynamic> _buildUpdateData() {
    final Map<String, dynamic> data = {};

    if (usernameC.text != initialProfile.username) {
      data['username'] = usernameC.text;
    }

    if (emailC.text != (initialProfile.email ?? '')) {
      data['email'] = emailC.text;
    }

    if (phoneC.text != (initialProfile.phone ?? '')) {
      data['phone'] = phoneC.text;
    }

    if (addressC.text != (initialProfile.address ?? '')) {
      data['address'] = addressC.text;
    }
    if (birthC.text != (initialProfile.birth ?? '')) {
      final date = DateTime.parse(birthC.text);
      data['birth'] = date.toIso8601String();
    }

    return data;
  }

  Future<void> handleUpdate() async {
    if (!_formkey.currentState!.validate()) return;

    final data = _buildUpdateData();
    if (data.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tidak ada perubahan')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final token = await SecureStorage.getToken();

      await ProfileService().updateProfile(token: token!, data: data);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile berhasil diperbarui')),
      );

      setState(() {
        isEdit = false;

        initialProfile = initialProfile.copyWith(
          username: usernameC.text,
          email: emailC.text,
          phone: phoneC.text,
          address: addressC.text,
        );
      });
    } catch (e) {
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
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF5E936C),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            _input(usernameC, "username", enabled: isEdit),
            _input(emailC, "email", email: true, enabled: isEdit),
            _input(phoneC, "phone", enabled: isEdit),
            _input(addressC, "Alamat", enabled: isEdit),
            _input(birthC, "Tanggal Lahir", enabled: isEdit),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black
                    ),
                    onPressed: () {
                      setState(() {
                        if (isEdit) {
                          _resetForm();
                        }
                        isEdit = !isEdit;
                      });
                    },
                    child: Text(isEdit ? 'Batal' : 'Edit'),
                  ),
                ),
                const SizedBox(height: 20),
                if (isEdit)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : handleUpdate,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : const Text('Simpan'),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _input(
  TextEditingController controller,
  String label, {
  bool email = false,
  bool enabled = true,
  int? min,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextFormField(
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        labelStyle: const TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
      validator: enabled
          ? (value) {
              if (value == null || value.isEmpty) {
                return "$label wajib diisi";
              }
              if (min != null && value.length < min) {
                return "$label minimal $min karakter";
              }
              if (email && !value.contains('@')) {
                return 'Email tidak valid';
              }
              return null;
            }
          : null,
    ),
  );
}
