import '../models/provider_model.dart';
import '../models/result_model.dart';

class ComparisonService {
  // 🔹 Generate results
  static List<Result> compare({
    required List<Provider> providers,
    required double distance,
  }) {
    List<Result> results = [];

    for (var p in providers) {
      double price = p.baseFare + (distance * p.pricePerKm);

      int time = (distance * 2).toInt();

      results.add(Result(provider: p.name, price: price, time: time));
    }

    return results;
  }

  // 🔹 Sort results
  static List<Result> sortResults(List<Result> results, String filter) {
    if (filter == "price") {
      results.sort((a, b) => a.price.compareTo(b.price));
    } else if (filter == "time") {
      results.sort((a, b) => a.time.compareTo(b.time));
    }
    return results;
  }
}
