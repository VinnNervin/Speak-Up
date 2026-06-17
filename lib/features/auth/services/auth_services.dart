import 'dart:convert';

import 'package:first_app/core/storage/local_storage_service.dart';
import 'package:first_app/features/auth/models/signin_request_model.dart';
import 'package:first_app/features/auth/models/signup_request_model.dart';
import 'package:first_app/features/auth/models/user_model.dart';

class AuthConstant {
  static final String _userKey = 'user_data';
}

class AuthServices {
  final LocalStorageService _storage;

  AuthServices(this._storage);

  Future<UserModel?> login(SigninRequestModel userRequestPayload) async {
    final storageData = _storage.getString(AuthConstant._userKey);

    if (storageData != null) {
      try {
        final user = UserModel.fromJson(jsonDecode(storageData));
        if (user.email == userRequestPayload.email &&
            user.password == userRequestPayload.password) {
          return user;
        }
      } catch (_) {}
    }

    final defaultUser = UserModel(
      id: "IDABB",
      name: "charles",
      email: "admin@gmail.com",
      password: '123',
    );

    if (defaultUser.email == userRequestPayload.email &&
        defaultUser.password == userRequestPayload.password) {
      return defaultUser;
    }
    return null;
  }

  Future<UserModel?> signUp(SignupRequestModel userRequestPayload) async {
    if (userRequestPayload.password != userRequestPayload.confirmPassword ||
        userRequestPayload.email.isEmpty &&
            userRequestPayload.password.isEmpty &&
            userRequestPayload.name.isEmpty) {
      return null;
    }

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: userRequestPayload.name,
      email: userRequestPayload.email,
      password: userRequestPayload.password,
    );

    await _storage.setString(AuthConstant._userKey, jsonEncode(user.toJson()));

    return user;
  }

  Future<UserModel?> getSavedUser() async {
    // final storageData = _storage.getString(AuthConstant._userKey);

    // if (storageData == null) return null;

    // return UserModel.fromJson(jsonDecode(storageData));
    return UserModel(id: "IDABB", name: "charles", email: "admin@gmail.com", password: '123');
  }
}
