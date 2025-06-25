import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smile_checker/providers/gemini_provider.dart';
import 'package:smile_checker/providers/media_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);
    final mediaProvider = Provider.of<MediaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Smile Checker')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await mediaProvider.pickImage();
        },
        tooltip: 'Upload Image',
        child: const Icon(Icons.upload_file),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to Smile Checker!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            if (mediaProvider.loading)
              const CircularProgressIndicator()
            else if (mediaProvider.selectedImage != null)
              Image.file(File(mediaProvider.selectedImage!.path), height: 200)
            else
              const Text('No image selected.'),
          ],
        ),
      ),
    );
  }
}
