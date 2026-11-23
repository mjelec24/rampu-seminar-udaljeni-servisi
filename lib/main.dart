import 'package:material_ui/material_ui.dart';

import 'data/repositories/auth_repository.dart';
import 'data/repositories/products_repository.dart';
import 'data/services/auth_service.dart';
import 'data/services/currency_service.dart';
import 'data/services/products_service.dart';
import 'ui/login/login_screen.dart';

void main() {
  final authRepository = AuthRepository(AuthService());
  final productsRepository = ProductsRepository(ProductsService(), CurrencyService());

  runApp(MiniTrznicaApp(
    authRepository: authRepository,
    productsRepository: productsRepository,
  ));
}

class MiniTrznicaApp extends StatelessWidget {
  const MiniTrznicaApp({
    super.key,
    required this.authRepository,
    required this.productsRepository,
  });

  final AuthRepository authRepository;
  final ProductsRepository productsRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini tržnica',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.orange),
      home: LoginScreen(
        authRepository: authRepository,
        productsRepository: productsRepository,
      ),
    );
  }
}