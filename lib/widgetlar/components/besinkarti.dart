import 'package:flutter/material.dart';

import '../../modeller/besinmodeli.dart';

class BesinKarti extends StatelessWidget {
  final BesinModeli besin;

  final VoidCallback? onTap;

  final VoidCallback? onDelete;

  const BesinKarti({
    super.key,
    required this.besin,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(12),
                child: Image.network(
                  besin.resimUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) {
                    return Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey.shade300,
                      child: const Icon(
                        Icons.image,
                        size: 40,
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      besin.ad,
                      style:
                          const TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Kalori: ${besin.kalori}",
                    ),

                    Text(
                      "Protein: ${besin.protein} g",
                    ),
                  ],
                ),
              ),

              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}