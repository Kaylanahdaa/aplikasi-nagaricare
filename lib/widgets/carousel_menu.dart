import 'package:aplikasi_nagaricare/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/carousel_menu_controller.dart';
import '../models/image_carousel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_viewer_carousel.dart';

class CarouselMenu extends StatelessWidget {
  const CarouselMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final CarouselMenuController controller =
        Get.put(CarouselMenuController()); // Initialize the controller

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /// Outer Style Indicators Banner Slider
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              aspectRatio: 16 / 8,
              viewportFraction: .95,
              onPageChanged: (index, reason) {
                controller.changePage(index);
              },
            ),
            items: AppData.outerStyleImages.map((imagePath) {
              return GestureDetector(
                onTap: () {
                  // Directly trigger the bottom modal when the image is tapped
                  CustomImageViewer.show(
                    context: context,
                    url: imagePath,
                    fit: BoxFit.fill,
                    radius: 24,
                  );
                },
                child: CachedNetworkImage(
                  imageUrl: imagePath,
                  fit: BoxFit.cover,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(24),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
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
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),

        /// Indicators
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                AppData.outerStyleImages.length,
                (index) {
                  bool isSelected = controller.outerCurrentPage.value == index;
                  return GestureDetector(
                    onTap: () {
                      controller.changePage(index);
                    },
                    child: AnimatedContainer(
                      width: isSelected ? 30 : 10,
                      height: 10,
                      margin:
                          EdgeInsets.symmetric(horizontal: isSelected ? 6 : 3),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accentColor
                            : Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                    ),
                  );
                },
              ),
            )),
      ],
    );
  }
}
