// =========================
// IMPORT LIBRARIES & FILES
// =========================
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/food_list_data.dart';  // Data game
import 'package:flutter_application_1/pages/profile_page.dart';   // Halaman profil
import 'package:flutter_application_1/pages/detail_page.dart';    // Halaman detail game
import 'package:flutter_application_1/pages/login_page.dart';     // Halaman login
import 'package:flutter_application_1/pages/favorite_page.dart';  // Halaman favorite

// =========================
// HOME PAGE (STATEFUL WIDGET)
// =========================
class HomePage extends StatefulWidget {
  final String username; // data username dikirim dari LoginPage
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

// =========================
// STATE CLASS
// =========================
class _HomePageState extends State<HomePage> {
  String searchQuery = "";          // menyimpan query pencarian
  int _selectedIndex = 0;           // index navigasi bottom bar
  List<dynamic> favorites = [];     // daftar game favorit user

  // =========================
  // HANDLE BOTTOM NAVIGATION
  // =========================
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // ubah index sesuai item yang dipilih
    });

    // Arahkan ke halaman sesuai item navigation
    if (index == 1) {
      // Navigasi ke FavoritePage dengan membawa data favorites
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FavoritePage(favorites: favorites),
        ),
      );
    } else if (index == 3) {
      // Navigasi ke ProfilePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ProfilePage()),
      );
    }
  }

  // =========================
  // HANDLE LOGOUT
  // =========================
  void _logout() {
    // Navigasi kembali ke LoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
    );
  }

  // =========================
  // BUILD UI
  // =========================
  @override
  Widget build(BuildContext context) {
    // Filter game berdasarkan pencarian user
    final filteredFoods = dummyFoods
        .where((food) =>
            food.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // =========================
              // HEADER
              // =========================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profil kecil dengan sapaan username
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://i.pravatar.cc/150?img=3"),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Sapaan menggunakan username dari LoginPage
                          Text(
                            "Hi ${widget.username}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            "Welcome 👋",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Tombol Logout
                  IconButton(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout, color: Colors.redAccent),
                    tooltip: "Logout",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // =========================
              // SEARCH BAR
              // =========================
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Search food...",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value; // update hasil pencarian
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // =========================
              // GAME LIST
              // =========================
              Wrap(
                spacing: 16,    // jarak antar card horizontal
                runSpacing: 16, // jarak antar card vertikal
                children: filteredFoods
                    .map((food) => _recommendCard(context, food))
                    .toList(),
              ),
            ],
          ),
        ),
      ),

      // =========================
      // BOTTOM NAVIGATION
      // =========================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,        // item aktif
        onTap: _onItemTapped,                // handle klik item
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
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

  // =========================
  // GAME CARD WIDGET
  // =========================
  Widget _recommendCard(BuildContext context, food) {
    final isFavorite = favorites.contains(food); // cek apakah game difavoritkan

    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail game saat card diklik
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailPage(food: food)),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.45, // ukuran card
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF1E1E1E),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================
            // GAMBAR GAME + ICON FAVORITE
            // =========================
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.network(
                    food.image,
                    fit: BoxFit.cover,
                    height: 120,
                    width: double.infinity,
                  ),
                ),
                // Icon favorite di pojok kanan atas
                Positioned(
                  right: 8,
                  top: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // Tambah / Hapus game dari favorites
                        if (isFavorite) {
                          favorites.remove(food);
                        } else {
                          favorites.add(food);
                        }
                      });
                    },
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? const Color.fromARGB(255, 132, 87, 255) : Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            // =========================
            // NAMA & HARGA GAME
            // =========================
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Nama game
                  Text(
                    food.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Harga game dengan efek gradasi
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
