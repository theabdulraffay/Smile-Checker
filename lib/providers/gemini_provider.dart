import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:smile_checker/repository/gemini_repository.dart';

class GeminiProvider extends ChangeNotifier {
  final GeminiRepository _geminiRepository = GeminiRepository(
    model: GenerativeModel(
      apiKey: dotenv.env['GEMINI_API_KEY'] ?? '',
      model: 'gemini-1.5-flash',
    ),
  );

  String? responseText;
  bool loading = false;

  Future<void> generateTextFromImage({
    required String prompt,
    required Uint8List imagebyte,
  }) async {
    loading = true;
    notifyListeners();

    try {
      responseText = await _geminiRepository.generateTextFromImage(
        prompt: prompt,
        imagebyte: imagebyte,
      );
    } catch (e) {
      responseText = 'Error: $e';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
