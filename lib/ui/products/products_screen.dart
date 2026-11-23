import 'package:material_ui/material_ui.dart';

import '../../data/repositories/products_repository.dart';
import '../details/details_screen.dart';
import '../error_message.dart';
import 'products_view_model.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.repository});

  final ProductsRepository repository;

  @override
  State<ProductsScreen> createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  late final viewModel = ProductsViewModel(widget.repository);
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: TextField(
            controller: searchController,
            onSubmitted: viewModel.search,
            decoration: const InputDecoration(
              hintText: 'Pretraži (npr. phone) i pritisni Enter',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: viewModel,
            builder: (context, _) {
              if (viewModel.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (viewModel.error != null) {
                return ErrorMessage(message: viewModel.error!, onRetry: viewModel.load);
              }
              if (viewModel.products.isEmpty) {
                return const Center(child: Text('Nema proizvoda.'));
              }
              return ListView.builder(
                itemCount: viewModel.products.length,
                itemBuilder: (context, index) {
                  final product = viewModel.products[index];
                  return ListTile(
                    leading: Image.network(
                      product.thumbnail,
                      width: 56,
                      errorBuilder: (context, error, stack) => const Icon(Icons.broken_image),
                    ),
                    title: Text(product.title),
                    subtitle: Text('${product.category} · ★ ${product.rating}'),
                    trailing: Text('${product.price} USD'),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => DetailsScreen(
                        repository: widget.repository,
                        productId: product.id,
                      ),
                    )),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}