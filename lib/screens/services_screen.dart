import 'package:flutter/material.dart';
import '../screens/category_screen.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              "Services",
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            const Text(
              "Go anywhere",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _gridSection(context, [
              _ServiceItem("Ride", Icons.directions_car),
              _ServiceItem("2-Wheels", Icons.two_wheeler),
              _ServiceItem("Rental Cars", Icons.car_rental, promo: true),
            ]),

            const SizedBox(height: 40),

            const Text(
              "Get anything delivered",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            _gridSection(context, [
              _ServiceItem("Food", Icons.restaurant, promo: true),
              _ServiceItem("Grocery", Icons.shopping_basket, promo: true),
              _ServiceItem("Convenience", Icons.store),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _gridSection(BuildContext context, List<_ServiceItem> items) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return _serviceCard(items[index], context);
      },
    );
  }

  Widget _serviceCard(_ServiceItem item, BuildContext context) {
    return GestureDetector(
      onTap: () {
        String category = "";

        switch (item.title.toLowerCase()) {
          case "ride":
            category = "ride";
            break;
          case "2-wheels":
            category = "2-wheels";
            break;
          case "rental cars":
            category = "rental";
            break;
          case "food":
            category = "food";
            break;
          case "grocery":
            category = "grocery";
            break;
          case "convenience":
            category = "convenience";
            break;
          default:
            category = "ride";
        }

        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CategoryScreen(category: category)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(item.icon, size: 32),
            const SizedBox(height: 8),
            Text(item.title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem {
  final String title;
  final IconData icon;
  final bool promo;

  _ServiceItem(this.title, this.icon, {this.promo = false});
}
