import 'package:flutter/material.dart';
import '../modeller/besinmodeli.dart';
import '../servisler/firebaseservice.dart';
import 'detayekran.dart';

class BesinListeEkrani extends StatelessWidget {
  BesinListeEkrani({super.key});

  final FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Besinler"),
      ),
      body: StreamBuilder<List<BesinModeli>>(
        stream: service.getBesinler(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Veri yüklenemedi"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final besinler = snapshot.data ?? [];

          if (besinler.isEmpty) {
            return const Center(
              child: Text("Hiç besin yok"),
            );
          }

          return ListView.builder(
            itemCount: besinler.length,
            itemBuilder: (context, index) {
              final besin = besinler[index];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: (besin.resimUrl.isNotEmpty)
                        ? NetworkImage(besin.resimUrl)
                        : null,
                    child: (besin.resimUrl.isEmpty)
                        ? const Icon(Icons.fastfood)
                        : null,
                  ),
                  title: Text(besin.ad),
                  subtitle: Text("${besin.kalori} kcal"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetayEkrani(besin: besin),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}