import 'package:flutter/material.dart';
import 'category_screen.dart';
import 'map_selection_screen.dart'; // ADD THIS

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [

            /// Rides / Eats tabs
            Row(
              children: [
                _tab("🚗 Rides", 0),
                const SizedBox(width: 20),
                _tab("🍔 Eats", 1),
              ],
            ),

            const SizedBox(height: 20),

            /// WHERE TO SEARCH BAR → OPENS MAP
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MapSelectionScreen(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "Where to?",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.access_time, size: 18),
                          SizedBox(width: 5),
                          Text("Now"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Suggestions title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Suggestions",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("See All"),
              ],
            ),

            const SizedBox(height: 20),

            /// Suggestions grid
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _serviceCard("Ride", Icons.directions_car, "ride"),
                _serviceCard("2-Wheels", Icons.two_wheeler, "ride"),
                _serviceCard("Delivery", Icons.local_shipping, "delivery"),
                _serviceCard("Food", Icons.restaurant, "food"),
              ],
            ),

            const SizedBox(height: 30),

            /// Promo banner
            Container(
              padding: const EdgeInsets.all(20),
              height: 130,
              decoration: BoxDecoration(
                color: Colors.red.shade700,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Save more with BACHAT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Compare prices across platforms instantly",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Tabs
  Widget _tab(String text, int index) {
    return GestureDetector(
      onTap: () => setState(() => selectedTab = index),
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: selectedTab == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
          const SizedBox(height: 6),
          if (selectedTab == index)
            Container(
              height: 3,
              width: 80,
              color: Colors.black,
            ),
        ],
      ),
    );
  }

  /// Service card
  Widget _serviceCard(String title, IconData icon, String category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryScreen(category: category),
          ),
        );
      },
      child: Container(
        width: 80,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(title),
          ],
        ),
      ),
    );
  }
}
