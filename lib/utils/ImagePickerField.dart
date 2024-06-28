import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerField extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const ImagePickerField({Key? key, required this.controller, required this.label}) : super(key: key);

  @override
  _ImagePickerFieldState createState() => _ImagePickerFieldState();
}

class _ImagePickerFieldState extends State<ImagePickerField> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      widget.controller.text = base64Encode(bytes);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          readOnly: true,
          decoration: InputDecoration(
            hintText: 'No file selected',
            suffixIcon: IconButton(
              icon: Icon(Icons.file_upload),
              onPressed: _pickImage,
            ),
          ),
        ),
        SizedBox(height: 8),
        if (widget.controller.text.isNotEmpty)
          Image.memory(base64Decode(widget.controller.text), height: 100, width: 100),
      ],
    );
  }
}
