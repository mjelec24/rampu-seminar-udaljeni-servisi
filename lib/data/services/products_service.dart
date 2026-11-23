import 'package:http/http.dart' as http;

import '../api.dart';
import '../models/product.dart';

class ProductsService {
  static const baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> getProducts() async {
    final products = <Product>[];
    for (final category in ['mens-shirts', 'mens-shoes', 'mens-watches']) {
      final json = await sendRequest(http.get(Uri.parse('$baseUrl/category/$category')));
      products.addAll((json['products'] as List).map((product) => Product.fromJson(product)));
    }
    return products;
  }

  Future<List<Product>> search(String query) async {
    final uri = Uri.parse('$baseUrl/search').replace(queryParameters: {'q': query});
    final json = await sendRequest(http.get(uri));
    return (json['products'] as List)
        .map((product) => Product.fromJson(product))
        .toList();
  }

  Future<Product> getProduct(int id) async {
    final json = await sendRequest(http.get(Uri.parse('$baseUrl/$id')));
    return Product.fromJson(json);
  }
}