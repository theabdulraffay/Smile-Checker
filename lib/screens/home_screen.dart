import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:smile_checker/providers/gemini_provider.dart';
import 'package:smile_checker/providers/media_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _showPicker(
    BuildContext context,
    MediaProvider mediaProvider,
  ) async {
    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text("Choose option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () async {
                  await mediaProvider.pickImage(ImageSource.gallery);
                  Navigator.of(ctx).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
                onTap: () async {
                  await mediaProvider.pickImage(ImageSource.camera);
                  Navigator.of(ctx).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final geminiProvider = Provider.of<GeminiProvider>(context);
    final mediaProvider = Provider.of<MediaProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Smile Checker')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _showPicker(context, mediaProvider);

          if (mediaProvider.selectedImage != null) {
            final imageBytes = await mediaProvider.selectedImage!.readAsBytes();
            await geminiProvider.generateTextFromImage(
              prompt:
                  'You are a dental health care assistant. Check the dental situation and give a score between 1- 10. Also analyze the teeths and give your feedback or any tips for the future. Keep your answer short and concise. \n If the image is not clear, say "Image not clear". or if image is not related to dental situation, say "Image not related to dental situation".',
              imagebyte: imageBytes,
            );
          } else {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('No image selected.')));
            geminiProvider.reset();
            mediaProvider.reset();
          }
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

            const SizedBox(height: 20),
            if (geminiProvider.loading)
              const CircularProgressIndicator()
            else if (geminiProvider.responseText != null)
              Text(
                geminiProvider.responseText!,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}
