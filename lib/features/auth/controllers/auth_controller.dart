import 'package:first_app/core/storage/local_storage_service.dart';
import 'package:first_app/features/auth/models/signin_request_model.dart';
import 'package:first_app/features/auth/models/signup_request_model.dart';
import 'package:first_app/features/auth/models/user_model.dart';
import 'package:first_app/features/auth/services/auth_services.dart';
import 'package:flutter/foundation.dart';
import 'package:form_validators_plus/form_validators_plus.dart';

class AuthController with ChangeNotifier {
  final AuthServices _authService;

  AuthController({required LocalStorageService storage}) : _authService = AuthServices(storage);

  // final AuthServices _authService = AuthServices();

  bool _isLoading = false;
  UserModel? _user;
  String? _errorMSg;

  bool get isLoading => _isLoading;
  UserModel? get user => _user;
  String? get errorMsg => _errorMSg;

  void _updateState({required bool isLoading, String? errorMsg}) {
    _isLoading = isLoading;
    _errorMSg = errorMsg;
    notifyListeners();
  }

  Future<bool> login(String inputEmail, String inputPassword) async {
    String email = inputEmail.trim();
    String password = inputPassword.trim();
    _updateState(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 1000));

    if (!email.isValidEmail) {
      _updateState(isLoading: false, errorMsg: 'Email tidak valid.');
      return false;
    }

    try {
      final result = await _authService.login(SigninRequestModel(email: email, password: password));

      if (result != null) {
        _user = result;
        _updateState(isLoading: false, errorMsg: null);
        return true;
      } else {
        _updateState(isLoading: false, errorMsg: "Email atau Kata sandi salah.");
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      _updateState(isLoading: false, errorMsg: "Terjadi kesalahan jaringan.");

      return false;
    }
  }

  Future<bool> signUp(
    String inputName,
    String inputEmail,
    String inputPassword,
    String inputConfirmPassword,
  ) async {
    String name = inputName.trim();
    String email = inputEmail.trim();
    String password = inputPassword.trim();
    String confirmPassword = inputConfirmPassword.trim();

    _updateState(isLoading: true);

    await Future.delayed(const Duration(milliseconds: 1000));

    if (!email.isValidEmail) {
      _updateState(isLoading: false, errorMsg: 'Email tidak valid.');
      return false;
    }

    if (password != confirmPassword) {
      _updateState(isLoading: false, errorMsg: "Kata sandi dan Konfirmasi kata sandi tidak cocok.");
      return false;
    }

    try {
      final result = await _authService.signUp(
        SignupRequestModel(
          name: name,
          email: email,
          password: password,
          confirmPassword: confirmPassword,
        ),
      );

      if (result != null) {
        _user = result;
        _updateState(isLoading: false);
        return true;
      } else {
        _updateState(isLoading: false, errorMsg: "ada yang salah");
        return false;
      }
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      _updateState(isLoading: false, errorMsg: 'terjadi kesalahan jaringan.');

      return false;
    }
  }

  Future<void> loadUserSession() async {
    _updateState(isLoading: true);

    try {
      final savedUser = await _authService.getSavedUser();
      if (savedUser != null) {
        _user = savedUser;
      }
    } catch (e) {
      debugPrint("Gagal memuat sesi user: $e");
    } finally {
      _updateState(isLoading: false);
    }
  }
}
