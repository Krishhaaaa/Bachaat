import 'package:flutter/material.dart';
import '../services/mock_api_service.dart';
import '../models/result_model.dart';
import '../widgets/result_tile.dart';

class ResultScreen extends StatefulWidget {
  final String category;
  final double value; // distance

  const ResultScreen({super.key, required this.category, required this.value});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<Result> results = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadResults(); // 👈 CALL HERE
  }

  Future<void> loadResults() async {
    try {
      // 🔥 YOUR CODE GOES HERE
      final providers = await MockApiService.fetchProviders();

      final resultsData = MockApiService.generateResults(
        providers: providers,
        distance: widget.value, // dynamic distance
      );

      final sorted = MockApiService.sortResults(resultsData, "price");

      setState(() {
        results = sorted;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.category.toUpperCase()} Results")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                return ResultTile(result: results[index]);
              },
            ),
    );
  }
}
