import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();

    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Pharmacie"),
        backgroundColor: const Color(0xFF00796B),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _dashboardCard(
              icon: Icons.point_of_sale,
              title: "Ventes",
              color: Colors.green,
              onTap: () {},
            ),
            _dashboardCard(
              icon: Icons.inventory,
              title: "Stock",
              color: Colors.orange,
              onTap: () {},
            ),
            _dashboardCard(
              icon: Icons.receipt_long,
              title: "Historique",
              color: Colors.blue,
              onTap: () {},
            ),
            _dashboardCard(
              icon: Icons.settings,
              title: "Paramètres",
              color: Colors.grey,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
