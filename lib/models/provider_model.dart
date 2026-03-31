class Provider {
  final String id;
  final String name;
  final String category;
  final double rating;
  final double baseFare;
  final double pricePerKm;
  final String logo;

  Provider({
    required this.id,
    required this.name,
    required this.category,
    required this.rating,
    required this.baseFare,
    required this.pricePerKm,
    required this.logo,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      rating: (json['rating'] as num).toDouble(),
      baseFare: (json['baseFare'] as num).toDouble(),
      pricePerKm: (json['pricePerKm'] as num).toDouble(),
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'rating': rating,
      'baseFare': baseFare,
      'pricePerKm': pricePerKm,
      'logo': logo,
    };
  }
}
