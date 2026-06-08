/*import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:uuid/uuid.dart';

import '../modeller/besinmodeli.dart';

import '../servisler/firebaseservice.dart';

import '../servisler/supabaseservice.dart';

class BesinEkleEkrani
    extends StatefulWidget {

  const BesinEkleEkrani({
    super.key,
  });

  @override
  State<BesinEkleEkrani>
      createState() =>
          _BesinEkleEkraniState();
}

class _BesinEkleEkraniState
    extends State<
        BesinEkleEkrani> {

  final formKey =
      GlobalKey<FormState>();

  final FirebaseService
      firebaseService =
      FirebaseService();

  final SupabaseService
      supabaseService =
      SupabaseService();

  final TextEditingController
      adController =
      TextEditingController();

  final TextEditingController
      kaloriController =
      TextEditingController();

  final TextEditingController
      proteinController =
      TextEditingController();

  final TextEditingController
      karbonhidratController =
      TextEditingController();

  final TextEditingController
      yagController =
      TextEditingController();

  Uint8List? imageBytes;

  Future<void> secResim()
      async {

    final picker =
        ImagePicker();

    final image =
        await picker.pickImage(
      source:
          ImageSource.gallery,
    );

    if (image != null) {

      imageBytes =
          await image.readAsBytes();

      setState(() {});
    }
  }

  Future<void> kaydet()
      async {

    if (!formKey.currentState!
        .validate()) {
      return;
    }

    String imageUrl = "";

    if (imageBytes != null) {

      imageUrl =
          await supabaseService
              .uploadImage(
        imageBytes!,
        "${const Uuid().v4()}.jpg",
      );
    }

    final besin =
        BesinModeli(
      id:
          const Uuid().v4(),

      ad:
          adController.text,

      kalori:
          int.parse(
              kaloriController.text),

      protein:
          int.parse(
              proteinController.text),

      karbonhidrat:
          int.parse(
              karbonhidratController
                  .text),

      yag:
          int.parse(
              yagController.text),

      resimUrl:
          imageUrl,
    );

    await firebaseService
        .addBesin(
      besin,
    );

    if (mounted) {

      ScaffoldMessenger.of(
              context)
          .showSnackBar(
        const SnackBar(
          content:
              Text("Kaydedildi"),
        ),
      );

      Navigator.pop(
        context,
      );
    }
  }

  @override
  Widget build(
      BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Besin Ekle",
        ),
      ),

      body: Padding(
        padding:
            const EdgeInsets.all(
                20),

        child: Form(
          key: formKey,

          child: ListView(
            children: [

              TextFormField(
                controller:
                    adController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Besin Adı",
                ),
              ),

              TextFormField(
                controller:
                    kaloriController,

                keyboardType:
                    TextInputType
                        .number,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Kalori",
                ),
              ),

              TextFormField(
                controller:
                    proteinController,

                keyboardType:
                    TextInputType
                        .number,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Protein",
                ),
              ),

              TextFormField(
                controller:
                    karbonhidratController,

                keyboardType:
                    TextInputType
                        .number,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Karbonhidrat",
                ),
              ),

              TextFormField(
                controller:
                    yagController,

                keyboardType:
                    TextInputType
                        .number,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Yağ",
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              ElevatedButton(
                onPressed:
                    secResim,

                child:
                    const Text(
                  "Resim Seç",
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              if (imageBytes != null)
                Image.memory(
                  imageBytes!,
                  height: 200,
                ),

              const SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed:
                    kaydet,

                child:
                    const Text(
                  "Kaydet",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/