// import library utama flutter
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';

/// =======================================
/// CLASS LOGIN PAGE
/// =======================================
/// - StatefulWidget karena kita butuh state
///   untuk menyimpan input user (username, password)
///   dan status visibility password.
///
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Controller untuk input username
  final usernameC = TextEditingController();

  /// Controller untuk input password
  final passwordC = TextEditingController();

  /// Boolean untuk mengatur apakah password terlihat atau tidak
  bool obscurePass = true;

  /// =======================================
  /// BUILD WIDGET UTAMA
  /// =======================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background utama (tema gelap)
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------------------------------------
              /// LOGO
              /// ---------------------------------------
              Center(
                child: Icon(Icons.ac_unit, color: Colors.purpleAccent, size: 60),
              ),
              const SizedBox(height: 40),

              /// ---------------------------------------
              /// TITLE / WELCOME TEXT
              /// ---------------------------------------
              const Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Hello, we miss you..",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 30),

              /// ---------------------------------------
              /// TEXTFIELD USERNAME
              /// ---------------------------------------
              _buildTextField(
                controller: usernameC,
                hint: "Username",
                icon: Icons.person_outlined,
                obscure: false,
              ),
              const SizedBox(height: 16),

              /// ---------------------------------------
              /// TEXTFIELD PASSWORD
              /// ---------------------------------------
              /// obscurePass digunakan untuk toggle show/hide password
              _buildTextField(
                controller: passwordC,
                hint: "Password",
                icon: Icons.lock_outline,
                obscure: obscurePass,
                suffix: IconButton(
                  onPressed: () {
                    // Toggle password visibility
                    setState(() => obscurePass = !obscurePass);
                  },
                  icon: Icon(
                    obscurePass ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// ---------------------------------------
              /// LOGIN BUTTON
              /// ---------------------------------------
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(
                    colors: [Colors.blueAccent, Colors.purpleAccent],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _login(context); // panggil fungsi login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// ---------------------------------------
              /// DIVIDER "OR"
              /// ---------------------------------------
              Row(
                children: const [
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "or",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  )),
                ],
              ),
              const SizedBox(height: 20),

              /// ---------------------------------------
              /// SOCIAL LOGIN BUTTONS (Google & Facebook)
              /// ---------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _socialButton("Google", Icons.g_mobiledata, Colors.white),
                  _socialButton("Facebook", Icons.facebook, Colors.white),
                ],
              ),
              const SizedBox(height: 30),

              /// ---------------------------------------
              /// REGISTER TEXT (Belum punya akun)
              /// ---------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don’t have an account? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// =======================================
  /// WIDGET TEXTFIELD CUSTOM
  /// =======================================
  /// digunakan untuk input username & password
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon: suffix, // untuk password toggle
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  /// =======================================
  /// WIDGET TOMBOL SOSIAL MEDIA
  /// =======================================
  /// contoh: Google, Facebook
  Widget _socialButton(String text, IconData icon, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2C2C2C),
            foregroundColor: color,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            // TODO: Tambahkan integrasi login sosial media
          },
          icon: Icon(icon, color: color),
          label: Text(
            text,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  /// =======================================
  /// FUNCTION LOGIN
  /// =======================================
  /// Logika login sederhana:
  /// - Jika username = admin & password = 1234
  ///   maka masuk ke HomePage
  /// - Jika salah, tampilkan SnackBar error
  void _login(BuildContext context) {
    String username = usernameC.text.trim();
    String password = passwordC.text.trim();

    if (username == "Aidil" && password == "101") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(username: username)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Gagal"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
