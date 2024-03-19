import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vegetables/constants.dart';

class ProductImagePicker extends StatefulWidget {
  const ProductImagePicker({super.key, required this.pickImage});

  final void Function(String image) pickImage;

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File? pickedImageShow;

  void pickImage() async {
    var pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        pickedImageShow = File(pickedImage.path);
      });
    } else {
      showtoast('No image picked', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pickImage();
      },
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: pickedImageShow != null
            ? Image.file(
                pickedImageShow!,
                fit: BoxFit.cover,
              )
            : const Icon(
                Icons.add_a_photo_outlined,
                size: 30,
              ),
      ),
    );
  }
}
