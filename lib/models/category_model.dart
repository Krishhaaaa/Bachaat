class Category {
  final String id;
  final String categoryName;
  final String icon;

  Category({required this.id, required this.categoryName, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['categoryName'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'categoryName': categoryName, 'icon': icon};
  }
}
