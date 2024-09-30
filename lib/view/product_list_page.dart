import 'package:ccampus_haat/view/food_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ccampus_haat/controller/product_controller.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController controller = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Add a listener to the scroll controller
    _scrollController.addListener(() {
      // Check if the user has scrolled to the bottom of the list
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Fetch more products
        controller.fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the scroll controller when the widget is removed
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.productList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            controller: _scrollController, // Attach the scroll controller here
            itemCount: controller.productList.length + (controller.hasMoreProducts.value ? 1 : 0), // Add one more for the loading indicator
            itemBuilder: (context, index) {
              if (index >= controller.productList.length) {
                // Return a loading indicator if more products are being fetched
                return const Center(child: CircularProgressIndicator());
              }

              final product = controller.productList[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    ProductCard(product),
                    if (product.discount > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3),
                            child: Text(
                              '${product.discount}% off',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        }
      }),
    );
  }
}
