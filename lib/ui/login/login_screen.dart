import 'package:material_ui/material_ui.dart';

import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/products_repository.dart';
import '../home/home_screen.dart';
import 'login_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.authRepository,
    required this.productsRepository,
  });

  final AuthRepository authRepository;
  final ProductsRepository productsRepository;

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late final viewModel = LoginViewModel(widget.authRepository);
  final usernameController = TextEditingController(text: 'michaelw');
  final passwordController = TextEditingController(text: 'michaelwpass');
  int minutes = 60;

  Future<void> login() async {
    final success = await viewModel.login(
      usernameController.text,
      passwordController.text,
      minutes,
    );
    if (success && mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => HomeScreen(
          authRepository: widget.authRepository,
          productsRepository: widget.productsRepository,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) => ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const SizedBox(height: 48),
              const Text(
                'Mini tržnica',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const Text('Prijava na DummyJSON servis', textAlign: TextAlign.center),
              const SizedBox(height: 32),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Korisničko ime'),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Lozinka'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                initialValue: minutes,
                decoration: const InputDecoration(labelText: 'Trajanje tokena'),
                items: const [
                  DropdownMenuItem(value: 60, child: Text('60 minuta')),
                  DropdownMenuItem(value: 1, child: Text('1 minuta (demo isteka tokena)')),
                ],
                onChanged: (value) => minutes = value ?? 60,
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: viewModel.isLoading ? null : login,
                child: Text(viewModel.isLoading ? 'Prijava…' : 'Prijava'),
              ),
              if (viewModel.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    viewModel.error!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}