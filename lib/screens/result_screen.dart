import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/local_api_service.dart';
import '../services/restaurant_api_service.dart';
import '../services/quick_commerce_service.dart';

class ResultScreen extends StatefulWidget {
  final String category;
  final double value;

  const ResultScreen({super.key, required this.category, required this.value});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Map<String, dynamic>> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadResults();
  }

  Future<void> openApp(String name) async {
    String url = "https://www.google.com/search?q=$name";
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> loadResults() async {
    try {
      final random = Random();

      // 🍔 FOOD
      if (widget.category == "food") {
        final data = await RestaurantApiService.fetchRestaurants();

        results = (data as List).map((item) {
          String priceStr = item['priceLevel'] ?? "\$\$";
          int level = priceStr.length;

          double price =
              (level * 120) + (widget.value * 10) + random.nextInt(50);

          double rating =
              double.tryParse(item['rating']?.toString() ?? "4.0") ?? 4.0;

          return {
            "name": item['name'] ?? "Restaurant",
            "price": price,
            "rating": rating,
            "time": 20 + random.nextInt(15),
          };
        }).toList();
      }
      // 🛒 QUICK COMMERCE
      else if (widget.category == "grocery" ||
          widget.category == "convenience") {
        final platforms = await QuickCommerceService.fetchPlatforms();

        results = platforms.map((name) {
          double price = 50 + (widget.value * 5) + Random().nextInt(50);

          return {
            "name": name,
            "price": price,
            "rating": 4.2,
            "time": 10 + Random().nextInt(10),
          };
        }).toList();
      }
      // 🚕 RIDE
      else {
        final providers = await LocalApiService.getProviders(widget.category);

        results = providers.map((p) {
          double price = p["baseFare"] + (widget.value * p["pricePerKm"]);

          return {
            "name": p["name"],
            "price": price,
            "rating": 4.0,
            "time": (widget.value * 2).toInt(),
          };
        }).toList();
      }

      // SORT
      results.sort((a, b) => a["price"].compareTo(b["price"]));

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text("${widget.category.toUpperCase()} Results")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : results.isEmpty
          ? const Center(child: Text("No data found"))
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final item = results[index];
                bool isCheapest = index == 0;

                return GestureDetector(
                  onTap: () => openApp(item["name"]),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: isCheapest
                          ? Border.all(color: Colors.green, width: 2)
                          : null,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.shopping_bag),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item["name"],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text("⭐ ${item["rating"]}"),
                              Text("${item["time"]} mins"),
                            ],
                          ),
                        ),

                        Text(
                          "₹${item["price"].toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
