import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ApiService {
  final String apiUrl = 'http://chprod-env.eba-psapqnmi.ap-south-1.elasticbeanstalk.com/webapi/products/productSearch';
  final apiKey = dotenv.env['API_KEY'] ?? 'No API Key Found';

  Future<List<Product>> fetchProducts({int page = 0}) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "creator": {
          "id": "6873",
          "creatorId": "298",
          "APIKey": apiKey,
          "applicationId": "1",
        },
        "campusId": "7740",
        "productCategory": {
          "selectedFilter": {"categoryId": "15"}
        },
        "productSection": "0",
        "loadType": 8,
        "limit": 10,
        "start": page * 10  // Pagination logic here
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Ensure 'productsList' is present and contains products
      if (data['productsList'] != null && data['productsList'][0]['products'] is List) {
        List<dynamic> productsJson = data['productsList'][0]['products'];

        // Convert each JSON object to Product
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        return []; // Return an empty list if no products found
      }
    } else {
      throw Exception('Failed to load products');
    }
  }
}
