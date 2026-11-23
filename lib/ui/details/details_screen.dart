import 'package:material_ui/material_ui.dart';

import '../../data/repositories/products_repository.dart';
import '../error_message.dart';
import 'details_view_model.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.repository, required this.productId});

  final ProductsRepository repository;
  final int productId;

  @override
  State<DetailsScreen> createState() => DetailsScreenState();
}

class DetailsScreenState extends State<DetailsScreen> {
  late final viewModel = DetailsViewModel(widget.repository, widget.productId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalji proizvoda')),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, _) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (viewModel.error != null) {
            return ErrorMessage(message: viewModel.error!, onRetry: viewModel.load);
          }
          final product = viewModel.product!;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Image.network(product.thumbnail, height: 200),
              const SizedBox(height: 12),
              Text(
                product.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(product.category),
              const SizedBox(height: 12),
              Text(
                '${product.price} USD',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(viewModel.eurPrice),
              const SizedBox(height: 12),
              Text(product.description),
              const SizedBox(height: 16),
              Text(
                'Recenzije (${product.reviews.length})',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              for (final review in product.reviews)
                ListTile(
                  leading: Text('★ ${review.rating}'),
                  title: Text(review.reviewerName),
                  subtitle: Text(review.comment),
                ),
            ],
          );
        },
      ),
    );
  }
}