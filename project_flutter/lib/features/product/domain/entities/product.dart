class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String shopName;
  final double rating;
  final String city;
  final int soldCount;
  final double? originalPrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.shopName,
    required this.rating,
    required this.city,
    required this.soldCount,
    this.originalPrice,
  });
}
