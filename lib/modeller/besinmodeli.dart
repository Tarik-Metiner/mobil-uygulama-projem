class BesinModeli {
  final String id;
  final String ad;
  final int kalori;
  final int protein;
  final int karbonhidrat;
  final int yag;
  final String resimUrl;

  BesinModeli({
    required this.id,
    required this.ad,
    required this.kalori,
    required this.protein,
    required this.karbonhidrat,
    required this.yag,
    required this.resimUrl,
  });

  factory BesinModeli.fromFirestore(Map<String, dynamic>? map) {
    map ??= {};

    int toInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      return int.tryParse(v.toString()) ?? 0;
    }

    String toStr(dynamic v) => v?.toString() ?? "";

    return BesinModeli(
      id: toStr(map["id"]),
      ad: toStr(map["ad"]),
      kalori: toInt(map["kalori"]),
      protein: toInt(map["protein"]),
      karbonhidrat: toInt(map["karbonhidrat"]),
      yag: toInt(map["yag"]),
      resimUrl: toStr(map["resimUrl"]),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "ad": ad,
      "kalori": kalori,
      "protein": protein,
      "karbonhidrat": karbonhidrat,
      "yag": yag,
      "resimUrl": resimUrl,
    };
  }
}