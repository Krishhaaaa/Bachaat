class LocalApiService {
  static Future<List<Map<String, dynamic>>> getProviders(
    String category,
  ) async {
    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    if (category == "ride") {
      return [
        {"name": "Uber", "baseFare": 50, "pricePerKm": 35},
        {"name": "Ola", "baseFare": 40, "pricePerKm": 24},
        {"name": "Rapido", "baseFare": 30, "pricePerKm": 19},
      ];
    } else if (category == "delivery") {
      return [
        {"name": "Dunzo", "baseFare": 20, "pricePerKm": 5},
        {"name": "Porter", "baseFare": 25, "pricePerKm": 6},
      ];
    }

    return [];
  }
}
