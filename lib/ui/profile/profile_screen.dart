import 'package:material_ui/material_ui.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/products_repository.dart';
import '../error_message.dart';
import '../login/login_screen.dart';
import 'profile_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
    required this.authRepository,
    required this.productsRepository,
  });

  final AuthRepository authRepository;
  final ProductsRepository productsRepository;

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  late final viewModel = ProfileViewModel(widget.authRepository);

  void logout() {
    viewModel.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          authRepository: widget.authRepository,
          productsRepository: widget.productsRepository,
        ),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.error != null) {
          return Column(
            children: [
              Expanded(child: ErrorMessage(message: viewModel.error!, onRetry: viewModel.load)),
              TextButton(onPressed: logout, child: const Text('Odjava')),
              const SizedBox(height: 24),
            ],
          );
        }
        final user = viewModel.user!;
        return ListView(
          padding: const EdgeInsets.all(24),
          children: [
            CircleAvatar(radius: 48, backgroundImage: NetworkImage(user.image)),
            const SizedBox(height: 12),
            Text(
              '${user.firstName} ${user.lastName}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(user.email, textAlign: TextAlign.center),
            const SizedBox(height: 24),
            const Text('Access token:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(viewModel.accessToken, maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 24),
            FilledButton(onPressed: viewModel.load, child: const Text('Osvježi profil')),
            TextButton(onPressed: logout, child: const Text('Odjava')),
          ],
        );
      },
    );
  }
}