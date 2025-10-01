import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/detail_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/profile_page.dart';

// ===============================
// FavoritePage: Halaman untuk menampilkan game favorit
// ===============================
class FavoritePage extends StatefulWidget {
  final List<dynamic> favorites; // daftar game favorit yang dikirim dari halaman lain

  const FavoritePage({super.key, required this.favorites});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  int _selectedIndex = 1; // default tab yang aktif: Favorites (index ke-1)

  // ===============================
  // Fungsi navigasi saat item BottomNavBar ditekan
  // ===============================
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // update index terpilih
    });

    if (index == 0) {
      // Jika Home dipilih → navigasi ke HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomePage(username: "Guest"), 
          // sementara pakai username "Guest", bisa diganti username asli
        ),
      );
    } else if (index == 3) {
      // Jika Profile dipilih → navigasi ke ProfilePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
      );
    }
    // index 1 = Favorites (sudah di halaman ini)
    // index 2 = Message (belum diimplementasikan)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // warna background utama

      // ===============================
      // AppBar
      // ===============================
      appBar: AppBar(
        title: const Text("My Favorites"),
        backgroundColor: const Color(0xFF1E1E1E),
      ),

      // ===============================
      // Body: cek apakah ada favorites
      // ===============================
      body: widget.favorites.isEmpty
          ? const Center(
              // Jika kosong, tampilkan teks default
              child: Text(
                "No favorites yet ❤️",
                style: TextStyle(color: Colors.white),
              ),
            )
          : Padding(
              // Jika ada isi → tampilkan dalam bentuk grid (Wrap)
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 16, // jarak horizontal antar item
                runSpacing: 16, // jarak vertikal antar item
                children: widget.favorites
                    .map((food) => _favoriteCard(context, food))
                    .toList(), // generate list card game favorit
              ),
            ),

      // ===============================
      // Bottom Navigation Bar
      // ===============================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // index tab aktif
        onTap: _onItemTapped, // event ketika tab dipilih
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.purpleAccent, // warna tab aktif
        unselectedItemColor: Colors.grey, // warna tab non-aktif
        type: BottomNavigationBarType.fixed, // supaya label selalu muncul
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorites"),
          BottomNavigationBarItem(
              icon: Icon(Icons.message_outlined), label: "Message"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

  // ===============================
  // Widget untuk menampilkan setiap card favorit
  // ===============================
  Widget _favoriteCard(BuildContext context, food) {
    return GestureDetector(
      // Jika card ditekan → buka DetailPage untuk game itu
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(food: food)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45, // set lebar card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF1E1E1E),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===============================
            // Bagian gambar game
            // ===============================
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                food.image, // ambil gambar pertama dari list
                fit: BoxFit.cover,
                height: 120,
                width: double.infinity,
              ),
            ),

            // ===============================
            // Bagian teks: nama dan harga game
            // ===============================
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nama game
                  Text(
                    food.name,
                    maxLines: 1, // hanya 1 baris, jika panjang → dipotong
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),

                  Text(
                    food.category,
                    maxLines: 1, // hanya 1 baris, jika panjang → dipotong
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color.fromARGB(255, 173, 173, 173),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Harga game (pakai gradient effect)
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Colors.blueAccent, Colors.purpleAccent],
                    ).createShader(bounds),
                    child: Text(
                      "Rp ${food.price}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
