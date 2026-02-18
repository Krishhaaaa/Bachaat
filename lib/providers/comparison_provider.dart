import 'package:flutter/material.dart';

class ResultModel {
  String provider;
  double price;
  int time;

  ResultModel({
    required this.provider,
    required this.price,
    required this.time,
  });
}

class ComparisonProvider extends ChangeNotifier {
  List<ResultModel> results = [];

  void searchFood(double basePrice) {
    results = [
      ResultModel(provider: "Zomato", price: basePrice + 40, time: 30),
      ResultModel(provider: "Swiggy", price: basePrice + 35, time: 28),
    ];
    _sort();
  }

  void searchDelivery(double distance) {
    results = [
      ResultModel(provider: "Porter", price: distance * 12, time: 45),
      ResultModel(provider: "Rapido", price: distance * 10, time: 35),
    ];
    _sort();
  }

  void searchRide(double distance) {
    results = [
      ResultModel(provider: "Uber", price: distance * 18, time: 12),
      ResultModel(provider: "Ola", price: distance * 16, time: 15),
    ];
    _sort();
  }

  void _sort() {
    results.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }
}
