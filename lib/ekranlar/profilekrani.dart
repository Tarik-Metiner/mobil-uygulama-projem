import 'package:flutter/material.dart';
import '../servisler/supabaseservice.dart';

class ProfilEkrani extends StatefulWidget {
  const ProfilEkrani({super.key});

  @override
  State createState() => _ProfilEkraniState();
}

class _ProfilEkraniState extends State {
  final SupabaseService service = SupabaseService();

  Map<String, dynamic>? user;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future loadUser() async {
    final data = await service.getUser(1);
    setState(() {
      user = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("Kullanıcı bulunamadı")),
      );
    }

    final name = (user?["adsoyad"] ?? "").toString();
    final email = (user?["email"] ?? "").toString();
    final fileName = (user?["fotograf"] ?? "").toString();

    final imageUrl =
        fileName.isNotEmpty ? service.getImageUrl(fileName) : null;

    return Scaffold(
      appBar: AppBar(title: const Text("Profil")),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      imageUrl != null ? NetworkImage(imageUrl) : null,
                  child: imageUrl == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
                const SizedBox(height: 20),
                Text(name, style: const TextStyle(fontSize: 22)),
                Text(email),
              ],
            ),
          ),
        ),
      ),
    );
  }
}