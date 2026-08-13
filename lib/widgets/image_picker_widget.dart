import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  final Function(File?) onImageSelected; // 🟢 Передаем фото наверх

  const ImagePickerWidget({super.key, required this.onImageSelected});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source); // захватываем фото с камеры или галереи 
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path); //если фото выбрано - сохраняем его в _imageFile 
      });
      widget.onImageSelected(_imageFile);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_imageFile != null)
           // Если фото есть - показываем его (высота 200, BoxFit.cover)
           // Покажи контейнер высотой 200 с закругленными углами
           ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.file(
        _imageFile!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
        ),
)
        else
           // Если фото нет - показываем иконку выбора (IconButton)
           Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    ElevatedButton.icon(
      onPressed: () => _pickImage(ImageSource.camera),
      icon: const Icon(Icons.camera_alt_rounded),
      label: const Text('Камера'), // потом вынесем в l10n
    ),
    ElevatedButton.icon(
      onPressed: () => _pickImage(ImageSource.gallery),
      icon: const Icon(Icons.photo_library_rounded),
      label: const Text('Галерея'), // потом вынесем в l10n
    ),
  ],
)

      ],
    );
  }
}
