import 'dart:convert';
import 'package:http/http.dart' as http;

class QuickCommerceService {
  static const String baseUrl = "https://quickcommerce-api.p.rapidapi.com";

  static const String apiKey =
      "64f2fc25camshcaa6d3a2042ccb1p10bf21jsnfa245cf70612";
  static const String host = "quickcommerce-api.p.rapidapi.com";

  // 🔥 THIS IS THE IMPORTANT METHOD
  static Future<List<String>> fetchPlatforms() async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/v1/supported-platforms"),
        headers: {"X-RapidAPI-Key": apiKey, "X-RapidAPI-Host": host},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("QC RESPONSE: $data");

        return List<String>.from(data['platforms']);
      } else {
        print("ERROR: ${response.body}");
        throw Exception("Failed");
      }
    } catch (e) {
      print("QC API ERROR: $e");
      return [];
    }
  }
}
