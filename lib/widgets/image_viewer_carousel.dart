import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImageViewer {
  CustomImageViewer._();

  static show(
      {required BuildContext context,
      required String url,
      BoxFit? fit,
      double? radius}) {
    return GestureDetector(
      onTap: () => {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Berita Bank Nagari'),
                content: Text(
                    "Non est Lorem est consequat et id aliqua ad aute nisi deserunt."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            })
      },
      child: CachedNetworkImage(
          imageUrl: url,
          fit: fit ?? BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.circular(
                    radius ?? 8,
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: fit ?? BoxFit.cover,
                  ),
                ),
              ),
          placeholder: (context, url) => Container(),
          errorWidget: (context, url, error) =>
              const Icon(Icons.error_outline)),
    );
  }
}
