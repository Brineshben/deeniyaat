import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController(text: 'teacher@deeniyat.com');
  final passwordController = TextEditingController(text: 'password123');
  final formKey = GlobalKey<FormState>();

  final RxBool isPasswordHidden = true.obs;
  final RxBool rememberMe = true.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe(bool? val) {
    rememberMe.value = val ?? false;
  }

  void login() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 600), () {
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.home);
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
