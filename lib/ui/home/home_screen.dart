import 'package:material_ui/material_ui.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/products_repository.dart';
import '../products/products_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.authRepository,
    required this.productsRepository,
  });

  final AuthRepository authRepository;
  final ProductsRepository productsRepository;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tab == 0 ? 'Proizvodi' : 'Profil')),
      body: IndexedStack(
        index: tab,
        children: [
          ProductsScreen(repository: widget.productsRepository),
          ProfileScreen(
            authRepository: widget.authRepository,
            productsRepository: widget.productsRepository,
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (index) => setState(() => tab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.storefront), label: 'Proizvodi'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}