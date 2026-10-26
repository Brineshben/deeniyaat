import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/utils/responsive.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (Figma 206:17448)
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEBF6D2),
                      Color(0xFFF9FAF5),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SafeArea(
            child: MaxWidthBox(
              maxWidth: 480,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 36.h),

                              // Logo (Left-aligned in Figma 206:17450)
                              Image.asset(
                                'assets/images/deeniyat_logo.png',
                                width: 121.w,
                                height: 33.h,
                                fit: BoxFit.contain,
                                alignment: Alignment.centerLeft,
                                errorBuilder: (context, error, stackTrace) =>
                                    const SizedBox.shrink(),
                              ),

                              SizedBox(height: 36.h),

                              // Greeting (Left-aligned in Figma 206:17471)
                              Text(
                                'Welcome Back.',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF32361B),
                                  letterSpacing: -0.2,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              ShaderMask(
                                shaderCallback: (bounds) => const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFF7D8F04),
                                    Color(0xFF4B5510),
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  'Empowering education, simplifying learning.',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    height: 1.25,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                              ),

                              SizedBox(height: 36.h),

                              // Email Field
                              Text(
                                'Email ID',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF32361B),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              TextFormField(
                                controller: controller.emailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 14.sp,
                                  color: const Color(0xFF32361B),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter Email ID',
                                  hintStyle: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 13.sp,
                                    color: const Color(0xFF767272),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 16.w, right: 10.w),
                                    child: SvgPicture.asset(
                                      'assets/icons/icon_letter.svg',
                                      width: 16.w,
                                      height: 16.w,
                                      colorFilter: const ColorFilter.mode(
                                        Color(0xFF32361B),
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 42.w,
                                    minHeight: 20.h,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF2F533A)
                                          .withValues(alpha: 0.30),
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                    borderSide: BorderSide(
                                      color: const Color(0xFF2F533A)
                                          .withValues(alpha: 0.30),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(50.r),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF424B0B),
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 16.h),

                              // Password Field
                              Text(
                                'Password',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF32361B),
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
                                    color: const Color(0xFF32361B),
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Enter Password',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 13.sp,
                                      color: const Color(0xFF767272),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 14.h,
                                    ),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.only(left: 16.w, right: 10.w),
                                      child: Icon(
                                        Icons.lock_outline_rounded,
                                        size: 18.sp,
                                        color: const Color(0xFF32361B),
                                      ),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                      minWidth: 42.w,
                                      minHeight: 20.h,
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 8.w),
                                      child: IconButton(
                                        icon: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0xFF32361B),
                                          size: 20.sp,
                                        ),
                                        onPressed:
                                            controller.togglePasswordVisibility,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF2F533A)
                                            .withValues(alpha: 0.30),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                      borderSide: BorderSide(
                                        color: const Color(0xFF2F533A)
                                            .withValues(alpha: 0.30),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(50.r),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF424B0B),
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 14.h),

                              // Remember Me & Forgot Password (Figma 206:17481)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: GestureDetector(
                                      onTap: () => controller.toggleRememberMe(
                                          !controller.rememberMe.value),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Obx(
                                            () => Container(
                                              width: 18.w,
                                              height: 18.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4.r),
                                                border: Border.all(
                                                  color: const Color(0xFF2F533A)
                                                      .withValues(alpha: 0.4),
                                                  width: 1.2,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: controller.rememberMe.value
                                                  ? Icon(
                                                      Icons.check,
                                                      size: 13.w,
                                                      color:
                                                          const Color(0xFF32361B),
                                                    )
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Flexible(
                                            child: Text(
                                              'Keep me signed in',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontFamily: 'Manrope',
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500,
                                                color: const Color(0xFF32361B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      'Forget Password?',
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF32361B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 24.h),

                              // Login Button (Figma 206:17486: Height 50, Color #8BA304, Pill 50.r)
                              Obx(
                                () => SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: ElevatedButton(
                                    onPressed: controller.isLoading.value
                                        ? null
                                        : controller.login,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF8BA304),
                                      foregroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.r),
                                      ),
                                    ),
                                    child: controller.isLoading.value
                                        ? SizedBox(
                                            height: 20.h,
                                            width: 20.h,
                                            child:
                                                const CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.white),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                              SizedBox(width: 8.w),
                                              SvgPicture.asset(
                                                'assets/icons/arrow_right_linear.svg',
                                                width: 16.w,
                                                height: 16.h,
                                                colorFilter:
                                                    const ColorFilter.mode(
                                                  Colors.white,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),

                              // Pushes footer to bottom
                              const Spacer(),

                              // Footer App Version (Figma 206:17487)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: Text(
                                    'Deeniyat Teacher App V 1.01',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xFF32361B)
                                          .withValues(alpha: 0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
