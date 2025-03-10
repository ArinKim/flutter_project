import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

getImage(ImageSource img) async {
  final ImagePicker imgPicker = ImagePicker();

  XFile? file = await imgPicker.pickImage(source: img);
  if (file != null) return await file.readAsBytes();
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
