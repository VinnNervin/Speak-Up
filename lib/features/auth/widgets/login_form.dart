import 'package:first_app/core/widgets/MainButton/main_button.dart';
import 'package:first_app/core/widgets/MainButton/main_button_config.dart';
import 'package:first_app/features/auth/widgets/auth_textfield.dart';
import 'package:first_app/theme/app_colors.dart';
import 'package:first_app/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:form_validators_plus/form_validators_plus.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController? confirmPasswordController;
  final VoidCallback onSubmit;
  final bool isLoading;
  final GlobalKey<FormState> formKey;

  const LoginForm({
    super.key,
    this.nameController,
    required this.emailController,
    required this.passwordController,
    this.confirmPasswordController,
    this.isLoading = false,
    required this.onSubmit,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
          color: Colors.white,
        ),
        padding: EdgeInsets.only(
          top: 50,
          left: 24,
          right: 24,
          bottom: confirmPasswordController != null ? 70 : 150,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              confirmPasswordController != null ? "Daftar" : "Masuk",
              style: TextStyle(
                fontSize: AppFonts.fontXLarge,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Text.rich(
              confirmPasswordController != null
                  ? TextSpan(
                      children: [
                        TextSpan(
                          text: "Selamat Datang di ",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
                        ),
                        TextSpan(
                          text: "Speak Up",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                        ),
                      ],
                    )
                  : TextSpan(text: "Selamat Datang!"),
            ),
            const SizedBox(height: 20),
            if (confirmPasswordController != null)
              AuthTextfield(
                controller: nameController!,
                label: 'Name',
                validator: Validators.combine([
                  Validators.required(message: 'Nama wajib di isi.'),
                  Validators.minLength(5, message: 'Minimal 5 karakter'),
                ]),
                hintText: 'Masukan Nama Anda',
                autocorrect: false,
                enableSuggestions: false,
                icon: LucideIcons.mail,
              ),
            const SizedBox(height: 10),
            AuthTextfield(
              controller: emailController,
              validator: Validators.combine([
                Validators.required(message: 'Email wajib diisi.'),
                Validators.minLength(5, message: 'Minimal 5 karakter'),
                Validators.email(message: 'Format email tidak valid.'),
              ]),
              label: 'Email',
              hintText: 'Masukan Email Anda',
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              enableSuggestions: false,
              icon: LucideIcons.mail,
            ),
            const SizedBox(height: 10),
            AuthTextfield(
              controller: passwordController,
              validator: Validators.combine([
                Validators.required(message: 'Kata sandi wajib diisi.'),
              ]),
              label: 'Kata Sandi',
              hintText: 'Masukan Kata sandi',
              obscureText: true,
              icon: LucideIcons.lockKeyhole,
            ),
            if (confirmPasswordController != null) ...[
              const SizedBox(height: 10),
              AuthTextfield(
                controller: confirmPasswordController!,
                label: 'Konfirmasi Kata Sandi ',
                hintText: 'Masukan ulang kata sandi',
                obscureText: true,
                icon: LucideIcons.lockKeyhole,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi kata sandi wajib diisi.';
                  }
                  if (value != passwordController.text) {
                    return 'Kata sandi konfirmasi tidak sesuai.';
                  }
                  return null; // Valid
                },
              ),
            ],
            const SizedBox(height: 26),
            MainButton(
              onPressed: onSubmit,
              config: MainButtonConfig(
                width: double.infinity,
                shadowColor: AppColors.primary.withValues(alpha: 0.5),
                label: isLoading
                    ? "LOADING..."
                    : (confirmPasswordController != null ? "DAFTAR" : "MASUK"),
                fontColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                if (confirmPasswordController != null) {
                  Navigator.popAndPushNamed(context, "/");
                } else {
                  Navigator.popAndPushNamed(context, '/signup');
                }
              },
              child: Text.rich(
                TextSpan(
                  text: confirmPasswordController != null
                      ? "Sudah punya akun? "
                      : "Belum punya akun? ",
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: confirmPasswordController != null ? "Masuk" : "Daftar",
                      style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
