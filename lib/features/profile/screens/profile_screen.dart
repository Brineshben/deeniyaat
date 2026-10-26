import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../routes/app_routes.dart';
import '../../navigation/widgets/animated_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBF6D2),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_screen_bg.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFEBF6D2),
                      Color(0xFFF3F9E6),
                      Color(0xFFFAFCF5),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Responsive Content
          SafeArea(
            bottom: false,
            child: MaxWidthBox(
              maxWidth: 480,
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                        child: Text(
                          'My profile',
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryOlive,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Scrollable content
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            bottom: 100.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Avatar with Edit Pen Icon
                              Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  Container(
                                    width: 90.w,
                                    height: 90.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.1),
                                          blurRadius: 10,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/teacher_avatar_ansari.png',
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            Container(
                                          color: const Color(0xFFF0EFE9),
                                          child: Icon(
                                            Icons.person,
                                            size: 48.w,
                                            color: AppColors.primaryOlive,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 28.w,
                                    height: 28.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryOlive,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white, width: 2),
                                    ),
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/icons/icon_pen.svg',
                                      width: 12.w,
                                      height: 12.w,
                                      colorFilter: const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),

                              // Name & EMP ID
                              Text(
                                'Ansari Ahamed',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryOlive,
                                  letterSpacing: -0.3,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'EMP 023',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryOlive.withValues(alpha: 0.7),
                                ),
                              ),
                              SizedBox(height: 20.h),

                              // Section 1: General information
                              _buildSectionHeader('General information'),
                              SizedBox(height: 8.h),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.03),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    _buildInfoRow(
                                      iconPath: 'assets/icons/icon_letter.svg',
                                      label: 'Mail Id',
                                      value: 'ansari.ahamed@deeniyat.com',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      child: const Divider(
                                        color: Color(0xFFF0EFE9),
                                        height: 1,
                                      ),
                                    ),
                                    _buildInfoRow(
                                      iconPath: 'assets/icons/icon_phone.svg',
                                      label: 'Contact Number',
                                      value: '+91 987 654 3219',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 18.h),

                              // Section 2: Institute information
                              _buildSectionHeader('Institute information'),
                              SizedBox(height: 8.h),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.03),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    _buildInfoRow(
                                      iconPath: 'assets/icons/icon_buildings.svg',
                                      label: 'Institute',
                                      value: 'Hilal Deeniyat Madrasa',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      child: const Divider(
                                        color: Color(0xFFF0EFE9),
                                        height: 1,
                                      ),
                                    ),
                                    _buildInfoRow(
                                      iconPath: 'assets/icons/icon_letter.svg',
                                      label: 'Mail Id',
                                      value: 'hilal.madrasa@deeniyat.com',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      child: const Divider(
                                        color: Color(0xFFF0EFE9),
                                        height: 1,
                                      ),
                                    ),
                                    _buildInfoRow(
                                      iconPath: 'assets/icons/icon_phone.svg',
                                      label: 'Contact Number',
                                      value: '+91 999 154 2456',
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12.h),
                                      child: const Divider(
                                        color: Color(0xFFF0EFE9),
                                        height: 1,
                                      ),
                                    ),
                                    _buildInfoRow(
                                      iconPath: 'assets/icons/icon_location.svg',
                                      label: 'Address',
                                      value: 'Hilal Masjid, Avera, Kuruva, Kannur',
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24.h),

                              // Logout Button
                              SizedBox(
                                width: double.infinity,
                                height: 50.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Get.offAllNamed(AppRoutes.login);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.oliveButton,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Floating Animated Bottom Navigation Bar
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20.h,
                    child: const AnimatedBottomNavBar(showProfileAvatar: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryOlive,
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String iconPath,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              iconPath,
              width: 16.w,
              height: 16.w,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryOlive,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryOlive,
              ),
            ),
          ],
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primaryOlive,
            ),
          ),
        ),
      ],
    );
  }
}
