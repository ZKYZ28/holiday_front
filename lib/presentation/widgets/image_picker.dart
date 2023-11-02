import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerForm extends StatefulWidget {
  final void Function(File pickedImage)? onImagePicked;

  ImagePickerForm({Key? key, this.onImagePicked}) : super(key: key);

  @override
  _ImagePickerFormState createState() => _ImagePickerFormState();
}

class _ImagePickerFormState extends State<ImagePickerForm> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
        widget.onImagePicked?.call(_image!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          _image == null
              ? const Text('Aucune image sélectionnée')
              : Column(
            children: [
              SizedBox(
                width: 200, // Largeur souhaitée
                height: 200, // Hauteur souhaitée
                child: Image.file(_image!),
              ),
              IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    _image = null;
                  });
                },
              ),
            ],
          ),

          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
            ),
            child: const Text('Sélectionner une image'),
          ),
        ],
      ),
    );
  }
}