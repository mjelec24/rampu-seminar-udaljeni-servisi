import 'package:material_ui/material_ui.dart';

import 'data/repositories/products_repository.dart';
import 'data/services/currency_service.dart';
import 'data/services/products_service.dart';
import 'ui/details/details_screen.dart';

void main() {
  final productsRepository = ProductsRepository(ProductsService(), CurrencyService());
  runApp(MiniTrznicaApp(productsRepository: productsRepository));
}

class MiniTrznicaApp extends StatelessWidget {
  const MiniTrznicaApp({super.key, required this.productsRepository});

  final ProductsRepository productsRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini tržnica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: DetailsScreen(repository: productsRepository, productId: 83),
    );
  }
}