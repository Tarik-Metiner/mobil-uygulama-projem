import 'package:flutter/material.dart';
import '../modeller/egzersizmodeli.dart';

class EgzersizDetayEkrani extends StatelessWidget {
  final EgzersizModeli egzersiz;

  const EgzersizDetayEkrani({
    super.key,
    required this.egzersiz,
  });

  Widget infoRow(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(egzersiz.egzersizAdi),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            egzersiz.resimUrl.isNotEmpty
                ? Image.network(
                    egzersiz.resimUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        height: 250,
                        child: Center(
                          child: Icon(Icons.broken_image, size: 50),
                        ),
                      );
                    },
                  )
                : const SizedBox(
                    height: 250,
                    child: Center(
                      child: Icon(Icons.fitness_center, size: 50),
                    ),
                  ),
            const SizedBox(height: 20),
            infoRow(Icons.timer, "Süre", "${egzersiz.sure} dk"),
            infoRow(Icons.local_fire_department, "Kalori", "${egzersiz.yakilanKalori} kcal"),
            infoRow(Icons.fitness_center, "Zorluk", egzersiz.zorluk),
          ],
        ),
      ),
    );
  }
}