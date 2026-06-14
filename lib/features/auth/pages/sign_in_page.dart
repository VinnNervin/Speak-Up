import 'package:first_app/features/auth/controllers/auth_controller.dart';
import 'package:first_app/features/auth/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _handleSignIn() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await context.read<AuthController>().login(
      emailController.text,
      passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.popAndPushNamed(context, '/home');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil Login')));
    } else {
      final errorMsg = context.read<AuthController>().errorMsg;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMsg ?? 'Login failed')));
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthController>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login-image.png'),
            fit: BoxFit.cover,
          ),
        ),
        height: double.infinity,
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: LoginForm(
            formKey: _formKey,
            emailController: emailController,
            isLoading: authProvider.isLoading,
            passwordController: passwordController,
            onSubmit: _handleSignIn,
          ),
        ),
      ),
    );
  }
}
