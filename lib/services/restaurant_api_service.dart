import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantApiService {
  static const String baseUrl = "https://tripadvisor16.p.rapidapi.com";

  static const String apiKey =
      "64f2fc25camshcaa6d3a2042ccb1p10bf21jsnfa245cf70612";
  static const String host = "tripadvisor16.p.rapidapi.com";

  static Future<List<dynamic>> fetchRestaurants() async {
    try {
      final response = await http.get(
        Uri.parse(
          "$baseUrl/api/v1/restaurant/searchRestaurants?locationId=304554",
        ),
        headers: {"X-RapidAPI-Key": apiKey, "X-RapidAPI-Host": host},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("FULL RESPONSE: $data");

        return data['data']?['data'] ?? []; // 🔥 FIXED
      } else {
        print("ERROR: ${response.body}");
        throw Exception("Failed");
      }
    } catch (e) {
      print("API ERROR: $e");
      return [];
    }
  }
}
