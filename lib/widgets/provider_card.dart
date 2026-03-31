import 'package:flutter/material.dart';
import '../models/provider_model.dart';

class ProviderCard extends StatelessWidget {
  final Provider provider;

  const ProviderCard({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(provider.logo)),
        title: Text(
          provider.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Rating: ${provider.rating} ⭐"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹${provider.baseFare}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text("Base Fare", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
