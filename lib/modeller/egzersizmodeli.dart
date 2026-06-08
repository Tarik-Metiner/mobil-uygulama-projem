class EgzersizModeli {
  final String id;
  final String egzersizAdi;
  final int sure;
  final int yakilanKalori;
  final String zorluk;
  final String resimUrl;

  EgzersizModeli({
    required this.id,
    required this.egzersizAdi,
    required this.sure,
    required this.yakilanKalori,
    required this.zorluk,
    required this.resimUrl,
  });

  factory EgzersizModeli.fromFirestore(
    Map<String, dynamic>? map,
  ) {
    map ??= {};

    int toInt(dynamic value) {
      if (value == null) return 0;
      if (value is int) return value;
      return int.tryParse(value.toString()) ?? 0;
    }

    return EgzersizModeli(
      id: map["id"]?.toString() ?? "",
      egzersizAdi: map["egzersizAdi"]?.toString() ?? "",
      sure: toInt(map["sure"]),
      yakilanKalori: toInt(map["yakilanKalori"]),
      zorluk: map["zorluk"]?.toString() ?? "",
      resimUrl: map["resimUrl"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "id": id,
      "egzersizAdi": egzersizAdi,
      "sure": sure,
      "yakilanKalori": yakilanKalori,
      "zorluk": zorluk,
      "resimUrl": resimUrl,
    };
  }
}