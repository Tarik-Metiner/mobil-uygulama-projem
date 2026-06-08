import 'package:flutter/material.dart';
import '../modeller/besinmodeli.dart';

class DetayEkrani extends StatelessWidget {
  final BesinModeli besin;

  const DetayEkrani({
    super.key,
    required this.besin,
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
        title: Text(besin.ad ?? "Detay"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (besin.resimUrl.isNotEmpty)
                ? Image.network(
                    besin.resimUrl,
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
                      child: Icon(Icons.fastfood, size: 50),
                    ),
                  ),
            const SizedBox(height: 20),
            infoRow(Icons.local_fire_department, "Kalori", "${besin.kalori ?? 0}"),
            infoRow(Icons.fitness_center, "Protein", "${besin.protein ?? 0} g"),
            infoRow(Icons.grain, "Karbonhidrat", "${besin.karbonhidrat ?? 0} g"),
            infoRow(Icons.opacity, "Yağ", "${besin.yag ?? 0} g"),
          ],
        ),
      ),
    );
  }
}