import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

class ImageResizer extends StatelessWidget {
  const ImageResizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          label: const Text("Choose picture"),
          icon: const Icon(Icons.camera),
          onPressed: () async {
            final ImagePicker _picker = ImagePicker();
            final XFile? image =
                await _picker.pickImage(source: ImageSource.gallery);
            if (image != null) {
              final rawImage = await image.readAsBytes();
              final bytes = await resizeImage(Uint8List.view(rawImage.buffer),
                  height: 250);
              if (bytes != null) {
                final testing = Image.memory(Uint8List.view(bytes.buffer));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return
                    AlertDialog(
                      title: Text("Image"),
                      content: testing,
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
