class MenuItem {
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final double rating;
  final String category;

  MenuItem({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.rating,
    required this.category,
  });

  factory MenuItem.fromJson(Map<String, dynamic> data) {
    return MenuItem(
      name: data['name'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      description: data['description'] ?? '',
      price: data['price']?.toDouble() ?? 0.0,
      rating: data['rating']?.toDouble() ?? 0.0,
      category: data['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'rating': rating,
      'category': category,
    };
  }
}
