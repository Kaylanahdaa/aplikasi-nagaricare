import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:aplikasi_nagaricare/constants/app_colors.dart';

class CustomImageViewer {
  CustomImageViewer._();

  static bool _isModalShowing = false;

  static show({
    required BuildContext context,
    required String url,
    BoxFit? fit,
    double? radius,
  }) {
    if (_isModalShowing) return;

    _isModalShowing = true;

    // Show the modal immediately
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.5,
          minChildSize: 0.4,
          maxChildSize: 0.8,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 40,
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Berita Bank Nagari',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CachedNetworkImage(
                      imageUrl: url,
                      fit: fit ?? BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(radius ?? 10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: fit ?? BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: 200,
                        color: Colors.grey[200],
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error_outline),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Non est Lorem est consequat et id aliqua ad aute nisi deserunt. Mollit ut sit voluptate non tempor. Ullamco sit aliqua quis laborum ullamco esse.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          _isModalShowing = false; // Reset the flag on close
                        },
                        child: const Text(
                          "OK",
                          style: TextStyle(
                            color: AppColors.accentColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
