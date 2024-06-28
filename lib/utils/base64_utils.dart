import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Uint8List decodeBase64Image(String base64String) {
  return base64Decode(base64String);
}

String encodeBase64Image(Uint8List imageBytes) {
  return base64Encode(imageBytes);
}

Future<String?> pickImageAndEncodeBase64() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  
  if (pickedFile != null) {
    Uint8List imageBytes = await pickedFile.readAsBytes();
    return encodeBase64Image(imageBytes);
  }
  return null;
}
