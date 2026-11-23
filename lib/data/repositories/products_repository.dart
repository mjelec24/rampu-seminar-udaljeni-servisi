import '../models/product.dart';
import '../services/currency_service.dart';
import '../services/products_service.dart';

class ProductsRepository {
  ProductsRepository(this.productsService, this.currencyService);

  final ProductsService productsService;
  final CurrencyService currencyService;

  Future<List<Product>> getProducts() => productsService.getProducts();

  Future<List<Product>> search(String query) => productsService.search(query);

  Future<Product> getProduct(int id) => productsService.getProduct(id);

  Future<double> getUsdToEur() => currencyService.getUsdToEur();
}