class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final String image;
  final double price;
  bool isSelected;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.image,
    required this.price,
    this.isSelected = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      price: json['price'].toDouble(),
    );
  }
}
