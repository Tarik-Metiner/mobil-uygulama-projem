import 'package:flutter/material.dart';

import '../servisler/firebaseservice.dart';
import '../servisler/sharedpreferencesservice.dart';

import '../widgetlar/global/customappdrawer.dart';
import '../widgetlar/global/custombottomnavbar.dart';

import 'besinlisteekrani.dart';
import 'egzersizlisteekrani.dart';
import 'profilekrani.dart';

class AnaEkran extends StatefulWidget {
  final Function(bool) onThemeChanged;

  const AnaEkran({
    super.key,
    required this.onThemeChanged,
  });

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  int selectedIndex = 0;

  final FirebaseService firebaseService = FirebaseService();
  final SharedPreferencesService prefs = SharedPreferencesService();

  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadTheme();
  }

  Future<void> loadTheme() async {
    final value = await prefs.getTheme();
    setState(() {
      isDarkMode = value;
    });
  }

  void changeTheme(bool value) {
    setState(() {
      isDarkMode = value;
    });

    prefs.saveTheme(value);
    widget.onThemeChanged(value);
  }

  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget get currentScreen {
    switch (selectedIndex) {
      case 1:
        return BesinListeEkrani();
      case 2:
        return EgzersizListeEkrani();
      case 3:
        return const ProfilEkrani();
      default:
        return dashboard();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sağlıklı Yaşam"),
      ),

      drawer: CustomDrawer(
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
        onNavigate: onTapped,
      ),

      body: SafeArea(
        child: currentScreen,
      ),

      bottomNavigationBar: CustomBottomNavbar(
        selectedIndex: selectedIndex,
        onItemTapped: onTapped,
      ),
    );
  }

  Widget statCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget dashboard() {
    return StreamBuilder(
      stream: firebaseService.getBesinler(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Bir hata oluştu"));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data ?? [];
        final toplamBesin = data.length;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  "Sağlıklı Yaşam",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 25),

                statCard(
                  "Toplam Besin",
                  "$toplamBesin",
                  Icons.restaurant,
                ),

                const SizedBox(height: 20),

                Column(
                  children: data.take(5).map((e) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.fastfood),
                          const SizedBox(width: 10),
                          Expanded(child: Text(e.ad)),
                          Text("${e.kalori} kcal"),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}