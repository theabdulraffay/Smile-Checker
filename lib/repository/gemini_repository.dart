import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiRepository {
  GenerativeModel model;

  GeminiRepository({required this.model});

  Future<String?> generateTextFromImage({
    required String prompt,
    required Uint8List imagebyte,
  }) async {
    final response = await model.generateContent([
      Content.multi([TextPart(prompt), DataPart('image/jpeg', imagebyte)]),
    ]);

    return response.text;
  }
}
