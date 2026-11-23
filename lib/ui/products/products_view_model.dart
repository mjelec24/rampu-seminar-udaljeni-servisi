import 'package:flutter/foundation.dart';

import '../../data/models/product.dart';
import '../../data/repositories/products_repository.dart';
import '../error_message.dart';

class ProductsViewModel extends ChangeNotifier {
  ProductsViewModel(this.repository) {
    load();
  }

  final ProductsRepository repository;

  bool isLoading = false;
  String? error;
  List<Product> products = [];

  Future<void> load() => fetch(repository.getProducts());

  Future<void> search(String query) {
    if (query.trim().isEmpty) return load();
    return fetch(repository.search(query.trim()));
  }

  Future<void> fetch(Future<List<Product>> request) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      products = await request;
    } catch (e) {
      error = errorText(e);
    }

    isLoading = false;
    notifyListeners();
  }
}