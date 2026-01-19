import 'package:flutter/material.dart';
import 'package:webean/service/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formkey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController birthController = TextEditingController();

  bool isLoading = false;

  Future<void> handleRegister() async {
    if (!_formkey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      await AuthService.register(
        username: usernameController.text,
        password: passwordController.text,
        email: emailController.text,
        phone: phoneController.text,
        address: addressController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registrasi Berhasil')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if(mounted){
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: ListView(
            children: [
              _input(usernameController, "Username"),
              _input(passwordController, "Password", obsecure: true, min: 8),
              _input(emailController, "Email", email: true),
              _input(phoneController, "No. Hp(+62)"),
              _input(addressController, "Alamat"),
              _input(addressController, "Tanggal Lahir (YYYY-MM-DD)"),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : handleRegister,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Daftar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(
    TextEditingController controller,
    String label, {
    bool obsecure = false,
    bool email = false,
    int? min,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: obsecure,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
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
        },
      ),
    );
  }
}
