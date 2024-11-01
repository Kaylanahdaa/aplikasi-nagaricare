import 'package:flutter/material.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';

class PictureBottomModal {
  PictureBottomModal._();

  static bool _isModalShowing = false;

  static show({
    required BuildContext context,
    required VoidCallback onSelectGallery,
    required VoidCallback onOpenCamera,
    required VoidCallback onDelete,
  }) {
    if (_isModalShowing) return;

    _isModalShowing = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.black),
                title: const Text('Take from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  onSelectGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.black),
                title: const Text('Open Camera'),
                onTap: () {
                  Navigator.pop(context);
                  onOpenCamera();
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete Profile Picture',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  onDelete();
                },
              ),
            ],
          ),
        );
      },
    ).then((_) {
      _isModalShowing = false;
    });
  }
}
