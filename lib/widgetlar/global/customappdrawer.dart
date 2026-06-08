import 'package:flutter/material.dart';
import '../../servisler/sqliteservice.dart';

class CustomDrawer extends StatefulWidget {
  final Function(int) onNavigate;
  final Function(bool) onThemeChanged;
  final bool isDarkMode;

  const CustomDrawer({
    super.key,
    required this.onNavigate,
    required this.onThemeChanged,
    required this.isDarkMode,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final SQLiteService sqliteService = SQLiteService();

  Map<String, dynamic>? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future loadUser() async {
    final data = await sqliteService.getUser();

    if (!mounted) return;

    setState(() {
      user = data;
      loading = false;
    });
  }

  void toggleTheme(bool value) {
    widget.onThemeChanged(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final name = user?["adsoyad"]?.toString() ?? "Kullanici";
    final email = user?["email"]?.toString() ?? "";
    final photo = user?["fotograf"]?.toString() ?? "";

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
                        photo.isNotEmpty ? NetworkImage(photo) : null,
                    child:
                        photo.isEmpty ? const Icon(Icons.person) : null,
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