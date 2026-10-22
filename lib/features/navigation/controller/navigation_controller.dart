import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxInt currentTabIndex = 0.obs;
  final RxBool isModuleSheetOpen = false.obs;

  late AnimationController moduleAnimationController;
  late Animation<double> expandAnimation;
  late Animation<double> fabRotationAnimation;
  late Animation<double> fadeAnimation;

  @override
  void onInit() {
    super.onInit();
    moduleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    expandAnimation = CurvedAnimation(
      parent: moduleAnimationController,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    fabRotationAnimation = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(
        parent: moduleAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );

    fadeAnimation = CurvedAnimation(
      parent: moduleAnimationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOut),
    );
  }

  @override
  void onClose() {
    moduleAnimationController.dispose();
    super.onClose();
  }

  void switchTab(int index) {
    if (isModuleSheetOpen.value) {
      closeModuleSheet();
    }
    currentTabIndex.value = index;
  }

  void toggleModuleSheet() {
    if (isModuleSheetOpen.value) {
      closeModuleSheet();
    } else {
      openModuleSheet();
    }
  }

  void openModuleSheet() {
    isModuleSheetOpen.value = true;
    moduleAnimationController.forward();
  }

  void closeModuleSheet() {
    isModuleSheetOpen.value = false;
    moduleAnimationController.reverse();
  }
}
