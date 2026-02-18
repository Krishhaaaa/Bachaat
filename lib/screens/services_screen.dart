import 'package:flutter/material.dart';

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

            /// Title
            const Text(
              "Services",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            /// GO ANYWHERE SECTION
            const Text(
              "Go anywhere",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _gridSection([
              _ServiceItem("Ride", Icons.directions_car),
              _ServiceItem("2-Wheels", Icons.two_wheeler),
              _ServiceItem("Rental Cars", Icons.car_rental, promo: true),
              _ServiceItem("Reserve", Icons.calendar_today),
              _ServiceItem("Group Ride", Icons.people),
              _ServiceItem("Hourly", Icons.access_time),
              _ServiceItem("Teens", Icons.person_outline),
            ]),

            const SizedBox(height: 40),

            /// DELIVERY SECTION
            const Text(
              "Get anything delivered",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _gridSection([
              _ServiceItem("Food", Icons.restaurant, promo: true),
              _ServiceItem("Grocery", Icons.shopping_basket, promo: true),
              _ServiceItem("Alcohol", Icons.local_bar, promo: true),
              _ServiceItem("Convenience", Icons.store),
              _ServiceItem("Health", Icons.medical_services),
              _ServiceItem("Personal Care", Icons.spa),
              _ServiceItem("Baby", Icons.child_care),
              _ServiceItem("Gourmet", Icons.fastfood),
            ]),
          ],
        ),
      ),
    );
  }

  /// GRID BUILDER
  Widget _gridSection(List<_ServiceItem> items) {
    return GridView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return _serviceCard(items[index]);
      },
    );
  }

  /// CARD UI
  Widget _serviceCard(_ServiceItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [

          /// PROMO TAG
          if (item.promo)
            Positioned(
              top: 6,
              right: 6,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "Promo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

          /// CONTENT
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, size: 32),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// MODEL CLASS
class _ServiceItem {
  final String title;
  final IconData icon;
  final bool promo;

  _ServiceItem(this.title, this.icon, {this.promo = false});
}
