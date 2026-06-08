import 'package:flutter/material.dart';

import '../modeller/egzersizmodeli.dart';
import '../servisler/firebaseservice.dart';
import 'egzersizdetayekrani.dart';

class EgzersizListeEkrani extends StatelessWidget {
  EgzersizListeEkrani({super.key});

  final FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Egzersizler"),
      ),
      body: StreamBuilder<List>(
        stream: service.getEgzersizler(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Hata: ${snapshot.error}"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final egzersizler = snapshot.data ?? <EgzersizModeli>[];

          if (egzersizler.isEmpty) {
            return const Center(
              child: Text("Egzersiz bulunamadı"),
            );
          }

          return ListView.builder(
            itemCount: egzersizler.length,
            itemBuilder: (context, index) {
              final egzersiz = egzersizler[index];

              return Card(
                margin: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: egzersiz.resimUrl.isNotEmpty
                        ? NetworkImage(egzersiz.resimUrl)
                        : null,
                    child: egzersiz.resimUrl.isEmpty
                        ? const Icon(Icons.fitness_center)
                        : null,
                  ),
                  title: Text(egzersiz.egzersizAdi),
                  subtitle: Text(
                    "${egzersiz.sure} dk • ${egzersiz.yakilanKalori} kcal",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EgzersizDetayEkrani(
                          egzersiz: egzersiz,
                        ),
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