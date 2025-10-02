import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scire/routing/routes.dart';
import 'package:scire/ui/auth/tilted_cards.dart';
import './auth_viewmodel.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.viewModel});

  final AuthViewModel viewModel;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isRegister = false;

  @override
  void initState() {
    super.initState();
    widget.viewModel.register.addListener(_onResult);
    widget.viewModel.login.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant AuthScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.register.removeListener(_onResult);
    oldWidget.viewModel.login.removeListener(_onResult);
    widget.viewModel.register.addListener(_onResult);
    widget.viewModel.login.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.register.removeListener(_onResult);
    widget.viewModel.login.removeListener(_onResult);
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    print("isRegister: " + _isRegister.toString());

    if (_isRegister) {
      widget.viewModel.register.execute((
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
      ));
    } else {
      widget.viewModel.login.execute((
        _emailController.text,
        _passwordController.text,
      ));
    }
  }

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    final toggleButtonText = _isRegister
        ? "Have an account? Login"
        : "Need an account? Register";

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.go(Routes.home),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                const TiltedCards(),
                const Spacer(flex: 1),
                Text(
                  'Welcome!',
                  style: textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Log in or register to sync your flashcards',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Spacer(flex: 2),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_isRegister)
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter a username' : null,
                        ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value!.isEmpty || !value.contains('@')
                            ? 'Please enter a valid email'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) => value!.length < 8
                            ? 'Password must be at least 8 characters'
                            : null,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(_isRegister ? "Register" : "Login"),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () => setState(() {
                          _isRegister = !_isRegister;
                          _clearForm();
                        }),
                        child: Text(toggleButtonText),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onResult() {
    final register = widget.viewModel.register;
    final login = widget.viewModel.login;

    if (register.completed || login.completed) {
      if (register.completed) {
        register.clearResult();
      } else if (login.completed) {
        login.clearResult();
      }
      context.go(Routes.home);
      _clearForm();
    }

    if (register.error || login.error) {
      if (register.error) {
        register.clearResult();
      } else if (login.error) {
        login.clearResult();
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Credentials is incorrect.")));
    }
  }
}
