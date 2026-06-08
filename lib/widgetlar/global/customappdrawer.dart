import 'package:flutter/material.dart';
import '../../servisler/sqliteservice.dart';
import '../../servisler/supabaseservice.dart';
import '../../servisler/sharedpreferencesservice.dart';

class CustomDrawer extends StatefulWidget {
  final Function(bool) onThemeChanged;
  final Function(int) onNavigate;
  final bool isDarkMode;

  const CustomDrawer({
    super.key,
    required this.onThemeChanged,
    required this.onNavigate,
    required this.isDarkMode,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final SupabaseService supabaseService = SupabaseService();
  final SharedPreferencesService prefsService = SharedPreferencesService();

  Map<String, dynamic>? user;
  bool loading = true;

  final String baseUrl =
      "https://sbnrqkgntlsyiknmsgds.supabase.co/storage/v1/object/public/resimler/";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final data = await supabaseService.getUser(1);
    setState(() {
      user = data;
      loading = false;
    });
  }

  String getPhotoUrl(String value) {
    if (value.isEmpty) return "";
    if (value.startsWith("http")) return value;
    return baseUrl + value;
  }

  Future<void> toggleTheme(bool value) async {
    await prefsService.saveTheme(value);
    widget.onThemeChanged(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final name = user?["adsoyad"] ?? "Kullanıcı";
    final email = user?["email"] ?? "";
    final photoRaw = (user?["fotograf"] ?? "").toString();
    final photoUrl = getPhotoUrl(photoRaw);

    return Drawer(
      child: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(name),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                    child: photoUrl.isEmpty
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ),

                
                SwitchListTile(
                  title: const Text("Koyu Tema"),
                  secondary: const Icon(Icons.dark_mode),
                  value: widget.isDarkMode,
                  onChanged: toggleTheme,
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("Ana Sayfa"),
                  onTap: () {
                    widget.onNavigate(0);
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: const Text("Besinler"),
                  onTap: () {
                    widget.onNavigate(1);
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: const Text("Egzersizler"),
                  onTap: () {
                    widget.onNavigate(2);
                    Navigator.pop(context);
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text("Profil"),
                  onTap: () {
                    widget.onNavigate(3);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
    );
  }
}