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
                title: Text(
                  'Berita Bank Nagari',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Container(
                  height: 300,
                  width: 300,
                  child: SingleChildScrollView(
                    child: Text(
                        "Non est Lorem est consequat et id aliqua ad aute nisi deserunt. Mollit ut sit voluptate non tempor. Ullamco sit aliqua quis laborum ullamco esse. Amet cupidatat est nostrud et magna laborum. Non deserunt amet duis non eiusmod veniam fugiat esse. Lorem aliqua amet magna anim id magna dolore duis exercitation elit. Anim consequat voluptate ad nostrud ipsum aliquip adipisicing eiusmod eu nisi. Mollit est ipsum pariatur consectetur occaecat cillum ex. Et Lorem do in in commodo minim consectetur consequat magna minim. Officia id aliqua aliqua cillum velit deserunt non ipsum. Aliquip sit do consectetur esse proident irure nostrud sunt in consectetur anim exercitation. Cupidatat quis nostrud id sunt est exercitation Lorem quis voluptate voluptate. Laborum esse commodo est ea occaecat id ad sint ullamco incididunt anim excepteur. Nisi culpa ex sunt irure in cupidatat minim velit aliqua in non officia. Eu commodo proident labore cupidatat magna occaecat proident culpa in commodo ullamco. Ut irure dolor eiusmod aliquip ut dolore fugiat eu ullamco qui consequat dolore."),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: AppColors.accentColor,
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
