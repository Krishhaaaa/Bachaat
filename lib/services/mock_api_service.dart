import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/provider_model.dart';
import '../models/result_model.dart';

class MockApiService {
  // 🔗 Replace with your actual MockAPI URL
  static const String baseUrl = "https://your-api.mockapi.io/api/v1";

  // ===============================
  // 🔹 FETCH PROVIDERS
  // ===============================
  static Future<List<Provider>> fetchProviders() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/providers'));

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        return data.map((e) => Provider.fromJson(e)).toList();
      } else {
        throw Exception("Failed to fetch providers");
      }
    } catch (e) {
      print("API Error: $e");
      return [];
    }
  }

  // ===============================
  // 🔹 FETCH FOOD DATA (OPTIONAL)
  // ===============================
  static Future<List<dynamic>> fetchFood() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/food'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to fetch food data");
      }
    } catch (e) {
      print("Food API Error: $e");
      return [];
    }
  }

  // ===============================
  // 🔹 FETCH DELIVERY DATA (OPTIONAL)
  // ===============================
  static Future<List<dynamic>> fetchDelivery() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/delivery'));

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception("Failed to fetch delivery data");
      }
    } catch (e) {
      print("Delivery API Error: $e");
      return [];
    }
  }

  // ===============================
  // 🔥 GENERATE RESULTS (CORE LOGIC)
  // ===============================
  static List<Result> generateResults({
    required List<Provider> providers,
    required double distance,
  }) {
    List<Result> results = [];

    for (var p in providers) {
      double price = p.baseFare + (distance * p.pricePerKm);

      int time = (distance * 2).toInt(); // simple estimation

      results.add(Result(provider: p.name, price: price, time: time));
    }

    return results;
  }

  // ===============================
  // 🔹 SORT RESULTS
  // ===============================
  static List<Result> sortResults(List<Result> results, String filter) {
    if (filter == "price") {
      results.sort((a, b) => a.price.compareTo(b.price));
    } else if (filter == "time") {
      results.sort((a, b) => a.time.compareTo(b.time));
    }
    return results;
  }
}
