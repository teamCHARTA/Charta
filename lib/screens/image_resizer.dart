import 'package:fast_image_resizer/fast_image_resizer.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;

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
            final rawImage = await rootBundle.load('assets/someImage.png');
            final bytes =
                await resizeImage(Uint8List.view(rawImage.buffer), width: 150);
            if (bytes != null) {
              final imageWidget = Image.memory(Uint8List.view(bytes.buffer));
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Image"),
                    content: imageWidget,
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
