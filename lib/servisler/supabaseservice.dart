import 'dart:typed_data';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient client = Supabase.instance.client;

  Future<String?> uploadProfileImage({
    required Uint8List bytes,
    required String fileName,
    required int userId,
  }) async {
    try {
      await client.storage
          .from('resimler')
          .uploadBinary(fileName, bytes, fileOptions: const FileOptions(upsert: true));

      await client
          .from('kullanicilar')
          .update({'fotograf': fileName})
          .eq('id', userId);

      return fileName;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUser(int userId) async {
    try {
      return await client
          .from('kullanicilar')
          .select()
          .eq('id', userId)
          .maybeSingle();
    } catch (e) {
      return null;
    }
  }

  String getImageUrl(String fileName) {
    return client.storage.from('resimler').getPublicUrl(fileName);
  }
}