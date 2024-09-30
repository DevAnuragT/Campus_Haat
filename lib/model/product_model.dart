class Product {
  final String id;
  final String title;
  final String info;
  final String imageUrl;
  final double originalPrice;
  final double currentPrice;
  final int discount;
  final int deliveryTime;
  final double rating;

  Product({
    required this.id,
    required this.title,
    required this.info,
    required this.imageUrl,
    required this.originalPrice,
    required this.currentPrice,
    required this.discount,
    required this.deliveryTime,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    // Check if mediaUrls is a list and has at least one element
    List<dynamic> mediaUrls = json['media'] != null && json['media']['mediaUrls'] is List ? json['media']['mediaUrls'] : [];

    return Product(
      id: json['id'] ?? '',
      title: json['title'] ?? 'No Title',
      info: json['info'] ?? 'No Info',
      imageUrl: mediaUrls.isNotEmpty ? mediaUrls[0] : '',  // Safely access first image URL
      originalPrice: json['productPricing'] != null ? json['productPricing']['originalPrice']?.toDouble() ?? 0.0 : 0.0,
      currentPrice: json['productPricing'] != null ? json['productPricing']['price']?.toDouble() ?? 0.0 : 0.0,
      discount: json['productPricing'] != null ? json['productPricing']['off'] ?? 0 : 0,
      deliveryTime: 15, // Default delivery time (you can update it based on actual data)
      rating: json['rating']?.toDouble() ?? 5, // Default to 0 if no rating available
    );
  }
}
