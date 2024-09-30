import 'package:get/get.dart';
import 'package:ccampus_haat/model/product_model.dart';
import 'package:ccampus_haat/services/product_services.dart';

class ProductController extends GetxController {
  var productList = <Product>[].obs;
  var isLoading = true.obs;
  var isFetchingMore = false.obs;
  var hasMoreProducts = true.obs;
  int currentPage = 0;  // Tracks the current page number

  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchInitialProducts();
    super.onInit();
  }

  // Fetch the initial set of products
  void fetchInitialProducts() async {
    try {
      isLoading(true);
      var products = await apiService.fetchProducts(page: currentPage);
      if (products.isNotEmpty) {
        productList.assignAll(products);
      }
      hasMoreProducts(products.isNotEmpty);
    } finally {
      isLoading(false);
    }
  }

  // Fetch more products when reaching the end of the list
  void fetchMoreProducts() async {
    if (isFetchingMore.value || !hasMoreProducts.value) return;

    try {
      isFetchingMore(true);
      currentPage++;
      var moreProducts = await apiService.fetchProducts(page: currentPage);
      if (moreProducts.isNotEmpty) {
        productList.addAll(moreProducts);
      } else {
        hasMoreProducts(false);  // No more products to load
      }
    } finally {
      isFetchingMore(false);
    }
  }
}
