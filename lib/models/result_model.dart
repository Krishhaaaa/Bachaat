class Result {
  final String provider;
  final double price;
  final int time;

  const Result({
    required this.provider,
    required this.price,
    required this.time,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      provider: json['provider'],
      price: (json['price'] as num).toDouble(),
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'provider': provider, 'price': price, 'time': time};
  }
}
