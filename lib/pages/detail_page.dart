// =========================
// IMPORT LIBRARIES & FILES
// =========================
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food_list.dart'; // Model game (data)
import 'package:url_launcher/url_launcher.dart'; // Untuk membuka link store di browser

// =========================
// DETAIL PAGE (STATLESS WIDGET)
// =========================
class DetailPage extends StatelessWidget {
  final Food food; // Data game yang dipilih user
  const DetailPage({super.key, required this.food});

  // =========================
  // METHOD: BUKA URL EKSTERNAL
  // =========================
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    // Buka link menggunakan aplikasi eksternal (browser)
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not launch $url");
    }
  }

  // =========================
  // BUILD UI
  // =========================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // =========================
      // APP BAR
      // =========================
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text(
          food.name, // tampilkan nama game
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Tombol back
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // =========================
      // BODY
      // =========================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // -------------------------
            // GAMBAR UTAMA GAME
            // -------------------------
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                food.image,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // -------------------------
            // CARD DETAIL GAME
            // -------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Game
                  Text(
                    food.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    food.category,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  // Rating Game
                  Row(
                    children: [
                      const SizedBox(width: 12),
                      Text(
                        "${food.ingredients} || ${food.calories} Calories",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Harga Game
                  Text(
                    "Price: Rp${food.price}",
                    style: const TextStyle(
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Tombol Resep
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _launchURL(food.recipeUrl), // buka link toko
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purpleAccent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        "Food's Recipe",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // -------------------------
            // ABOUT GAME
            // -------------------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "About",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    food.description, //deskripsi game
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}
