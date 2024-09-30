import 'package:flutter/material.dart';

import '../model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard(this.product);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(
                  product.imageUrl.isNotEmpty
                      ? product.imageUrl
                      : 'https://uxwing.com/meal-food-icon/',
                  width: 110,
                  height: 110,
                  fit: BoxFit.cover,
                ),
                // Floating rating over the image
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title with Veg/Non-Veg Indicator
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        product.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis, // Prevents overflow
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.eco,
                      color: Colors.green,
                      size: 20, // Increase the size to make it more visible
                    ),
                  ],
                ),
                // Product Info (description/ingredients)
                Text(
                  product.info,
                  style: TextStyle(color: Colors.grey[600],fontSize: 13),
                  overflow: TextOverflow.ellipsis, // Prevents overflow
                  maxLines: 2, // Limits to two lines
                ),
                // Icons for delivery time and meal type
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      '${product.deliveryTime} mins',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.restaurant_menu, size: 16, color: Colors.black),
                    SizedBox(width: 4),
                    Text(
                      'Lunch & Dinner',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹ ${product.currentPrice}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.blue,
                      ),
                    ),
                    // SizedBox(width: 4,),
                    if(product.currentPrice!=product.originalPrice)
                      Text(
                        '₹ ${product.originalPrice}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(5, 3, 8, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle add to cart functionality
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.blue, fontSize: 15),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10), // Adjusted vertical size
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
