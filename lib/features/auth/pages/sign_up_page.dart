import 'package:first_app/features/auth/controllers/auth_controller.dart';
import 'package:first_app/features/auth/widgets/login_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await context.read<AuthController>().signUp(
      nameController.text,
      emailController.text,
      confirmPasswordController.text,
      passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.popAndPushNamed(context, '/');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Berhasil membuat akun')));
    } else {
      final errorMsg = context.read<AuthController>().errorMsg;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMsg ?? 'Sign Up failed')));
    }

    setState(() {});
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: LoginForm(
          formKey: _formKey,
          nameController: nameController,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          onSubmit: _handleSignUp,
        ),
      ),
    );
  }
}
