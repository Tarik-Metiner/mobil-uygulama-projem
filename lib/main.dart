import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/firebase_options.dart';
import 'config/supabase_config.dart';
import 'tema/app_theme.dart';
import 'ekranlar/anaekran.dart';
import 'servisler/sharedpreferencesservice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl.trim(),
    anonKey: SupabaseConfig.supabaseAnonKey.trim(),
  );

  runApp(const SaglikliYasamApp());
}

class SaglikliYasamApp extends StatelessWidget {
  const SaglikliYasamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AppRoot();
  }
}

class _AppRoot extends StatefulWidget {
  const _AppRoot();

  @override
  State<_AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<_AppRoot> {
  final SharedPreferencesService prefs =
      SharedPreferencesService();

  bool darkMode = false;
  bool loaded = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final value = await prefs.getTheme();

    setState(() {
      darkMode = value;
      loaded = true;
    });
  }

  Future<void> changeTheme(bool value) async {
    await prefs.saveTheme(value);

    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loaded) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Sağlıklı Yaşam",
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          darkMode ? ThemeMode.dark : ThemeMode.light,
      home: AnaEkran(
        onThemeChanged: changeTheme,
      ),
    );
  }
}