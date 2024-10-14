import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_controller.dart';

class CarouselMenuController extends GetxController {
  var outerCurrentPage = 0.obs;
  CarouselController outerCarouselController = CarouselController();

  void changePage(int index) {
    outerCurrentPage.value = index;
    outerCarouselController.jumpToPage(index);
  }
}

extension on CarouselController {
  void jumpToPage(int index) {}
}
