import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/comparison_provider.dart';

class ResultScreen extends StatefulWidget {
  final String category;
  final double value;

  const ResultScreen({
    super.key,
    required this.category,
    required this.value,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    final provider =
        Provider.of<ComparisonProvider>(context, listen: false);

    if (widget.category == "food") {
      provider.searchFood(widget.value);
    } else if (widget.category == "delivery") {
      provider.searchDelivery(widget.value);
    } else {
      provider.searchRide(widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ComparisonProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Results")),
      body: ListView.builder(
        itemCount: provider.results.length,
        itemBuilder: (context, i) {
          final r = provider.results[i];

          return Card(
            child: ListTile(
              title: Text(r.provider),
              subtitle: Text("₹${r.price} • ${r.time} min"),
            ),
          );
        },
      ),
    );
  }
}
