import 'package:flutter/material.dart';
import '../models/result_model.dart';

class ResultTile extends StatelessWidget {
  final Result result;

  const ResultTile({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(
          result.provider,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("Time: ${result.time} mins"),
        trailing: Text(
          "₹${result.price}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
