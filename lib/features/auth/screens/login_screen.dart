import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFF9FAF5),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 48.h),

                    // Logo
                    Center(
                      child: Image.asset(
                        'assets/images/deeniyat_logo.png',
                        height: 56.h,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                      ),
                    ),

                    SizedBox(height: 28.h),

                    // Greeting (Centered in Figma 174:3131)
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Welcome Back.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 30.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryOlive,
                              letterSpacing: -0.5,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Empowering teachers, simplifying learning.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.subtitleOlive,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 36.h),

                    // Email Field
                    Text(
                      'Email ID',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.subtitleOlive,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14.sp,
                        color: AppColors.textDark,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter Email ID',
                        hintStyle: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14.sp,
                          color: AppColors.textMuted,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 18.w, right: 12.w),
                          child: Icon(
                            Icons.mail_outline_rounded,
                            size: 20.sp,
                            color: AppColors.subtitleOlive,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                          vertical: 15.h,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: BorderSide(
                            color: Colors.black.withValues(alpha: 0.10),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: BorderSide(
                            color: Colors.black.withValues(alpha: 0.10),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: const BorderSide(
                            color: AppColors.primaryOlive,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),

                    // Password Field
                    Text(
                      'Password',
                      style: TextStyle(
                        fontFamily: 'Manrope',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.subtitleOlive,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => TextFormField(
                        controller: controller.passwordController,
                        obscureText: controller.isPasswordHidden.value,
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 14.sp,
                          color: AppColors.textDark,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 14.sp,
                            color: AppColors.textMuted,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(left: 18.w, right: 12.w),
                            child: Icon(
                              Icons.lock_outline_rounded,
                              size: 20.sp,
                              color: AppColors.subtitleOlive,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 15.h,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: BorderSide(
                              color: Colors.black.withValues(alpha: 0.10),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: BorderSide(
                              color: Colors.black.withValues(alpha: 0.10),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: const BorderSide(
                              color: AppColors.primaryOlive,
                              width: 1.5,
                            ),
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: AppColors.subtitleOlive,
                                size: 20.sp,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Obx(
                                () => SizedBox(
                                  height: 24.h,
                                  width: 24.w,
                                  child: Checkbox(
                                    value: controller.rememberMe.value,
                                    onChanged: controller.toggleRememberMe,
                                    activeColor: AppColors.primaryOlive,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.w),
                              Flexible(
                                child: GestureDetector(
                                  onTap: () => controller.toggleRememberMe(
                                      !controller.rememberMe.value),
                                  child: Text(
                                    'Keep me signed in',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.subtitleOlive,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forget Password?',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'Manrope',
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.subtitleOlive,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 28.h),

                    // Login Button (Pill 50.r, Height 54.h in Figma)
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 54.h,
                        child: ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.loginButtonGreen,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Login',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 10.w),
                                    SvgPicture.asset(
                                      'assets/icons/arrow_right_linear.svg',
                                      width: 16.w,
                                      height: 16.h,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),

                    SizedBox(height: 36.h),

                    // Footer App Version
                    Center(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 24.h),
                        child: Text(
                          'Deeniyat Teacher App V 1.01',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.subtitleOlive,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
