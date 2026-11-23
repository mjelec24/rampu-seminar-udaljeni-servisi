import 'package:flutter/foundation.dart';

import '../../data/models/product.dart';
import '../../data/repositories/products_repository.dart';
import '../error_message.dart';

class DetailsViewModel extends ChangeNotifier {
  DetailsViewModel(this.repository, this.productId) {
    load();
  }

  final ProductsRepository repository;
  final int productId;

  bool isLoading = true;
  String? error;
  Product? product;
  String eurPrice = '';

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      product = await repository.getProduct(productId);
    } catch (e) {
      error = errorText(e);
    }
    isLoading = false;
    notifyListeners();

    if (product != null) await loadEurPrice();
  }

  Future<void> loadEurPrice() async {
    try {
      final rate = await repository.getUsdToEur();
      eurPrice = '≈ ${(product!.price * rate).toStringAsFixed(2)} EUR';
    } catch (e) {
      eurPrice = 'Cijena u EUR trenutno nije dostupna.';
    }
    notifyListeners();
  }
}