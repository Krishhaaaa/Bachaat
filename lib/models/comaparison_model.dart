import 'result_model.dart';

class Comparison {
  final String id;
  final String userId;
  final String category;
  final String searchQuery;
  final List<Result> results;

  Comparison({
    required this.id,
    required this.userId,
    required this.category,
    required this.searchQuery,
    required this.results,
  });

  factory Comparison.fromJson(Map<String, dynamic> json) {
    return Comparison(
      id: json['id'],
      userId: json['userId'],
      category: json['category'],
      searchQuery: json['searchQuery'],
      results: (json['results'] as List)
          .map((e) => Result.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'category': category,
      'searchQuery': searchQuery,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}
