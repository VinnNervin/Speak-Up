import 'package:first_app/core/storage/local_storage_service.dart';
import 'package:first_app/features/auth/controllers/auth_controller.dart';
import 'package:first_app/core/controllers/language_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await SharedPreferences.getInstance();

  final localStorage = LocalStorageService(preferences);

  await initializeDateFormatting('id_ID', null);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Color.fromARGB(0, 255, 255, 255),
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<LocalStorageService>.value(value: localStorage),
        ChangeNotifierProvider(
          create: (context) =>
              AuthController(storage: context.read<LocalStorageService>())..loadUserSession(),
        ),
        ChangeNotifierProvider(create: (_) => LanguageController()),
      ],
      child: const MyApp(),
    ),
  );
}
