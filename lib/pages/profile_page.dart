import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Admin Profile",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto Profil
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=12",
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Card Data Admin
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E1E),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  ProfileItem(
                      icon: Icons.person,
                      title: "Nama",
                      value: "Aidil Addzikra"),
                  Divider(color: Colors.grey),
                  ProfileItem(
                      icon: Icons.email,
                      title: "Email",
                      value: "124230101@student.upnyk.ac.id"),
                  Divider(color: Colors.grey),
                  ProfileItem(
                      icon: Icons.badge, title: "Role", value: "Mahasiswa Sistem Informasi"),
                  Divider(color: Colors.grey),
                  ProfileItem(
                      icon: Icons.phone,
                      title: "No. Telepon",
                      value: "+62 813-3827-4675"),
                  Divider(color: Colors.grey),
                  ProfileItem(
                      icon: Icons.date_range,
                      title: "Bergabung Sejak",
                      value: "Agustus 2023"),
                  Divider(color: Colors.grey),
                  ProfileItem(
                      icon: Icons.location_on,
                      title: "Alamat",
                      value: "Condongcatur, Depok, Sleman, Yogyakarta"),
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

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12)),
              const SizedBox(height: 2),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white)),
            ],
          ),
        ),
      ],
    );
  }
}
