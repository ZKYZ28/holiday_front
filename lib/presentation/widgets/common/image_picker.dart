import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerForm extends StatefulWidget {
  final void Function(File? pickedImage, bool deleteImage) onImagePicked;
  String? initialPath;

  ImagePickerForm({super.key, required this.onImagePicked, this.initialPath});

  @override
  _ImagePickerFormState createState() => _ImagePickerFormState();
}

class _ImagePickerFormState extends State<ImagePickerForm> {
  File? _image;
  String? _currentImagePath;

  @override
  void initState() {
    super.initState();
    _currentImagePath = widget.initialPath;
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        widget.onImagePicked.call(_image!, true);
      });
    }
  }

  void handleDeleteImage() {
    setState(() {
      _image = null;
      _currentImagePath = null;
      widget.onImagePicked.call(null, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          if (_image != null)
            ImageSection(image: Image.file(_image!), onDelete: handleDeleteImage)
          else if (_currentImagePath != null)
            ImageSection(
                image: Image.network(
                  'https://10.0.2.2:7048/${_currentImagePath}',
                ),
                onDelete: handleDeleteImage
            )
          else
            const Text('Aucune image sélectionnée'),

          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A)),
            child: const Text('Sélectionner une image'),
          ),
        ],
      ),
    );
  }
}

class ImageSection extends StatelessWidget {
  final Widget image;
  final VoidCallback onDelete;

  const ImageSection({super.key, required this.image, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 200, height: 200, child: image),
        IconButton(icon: const Icon(Icons.delete, color: Colors.red), onPressed: onDelete),
      ],
    );
  }
}
