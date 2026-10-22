import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../controller/navigation_controller.dart';

class AnimatedBottomNavBar extends StatelessWidget {
  final ValueChanged<int> onTabSelected;
  final Function(String moduleName)? onModuleSelected;

  const AnimatedBottomNavBar({
    super.key,
    required this.onTabSelected,
    this.onModuleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final navCtrl = Get.find<NavigationController>();

    return AnimatedBuilder(
      animation: navCtrl.moduleAnimationController,
      builder: (context, child) {
        final expandProgress = navCtrl.expandAnimation.value;
        final currentHeight = 58.h + (191.h * expandProgress);
        final currentRadius = 48.r - (24.r * expandProgress);

        return Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            // Bottom bar container row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Expanding Pill Container (Figma 66:4638 -> 66:4639)
                  Expanded(
                    child: Container(
                      height: currentHeight,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(currentRadius),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: expandProgress < 0.3
                          ? _buildCompactTabs(navCtrl)
                          : _buildExpandedModules(navCtrl, expandProgress),
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Floating Circular Toggle Button (4-squares <-> Close X)
                  GestureDetector(
                    onTap: navCtrl.toggleModuleSheet,
                    child: Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: navCtrl.fabRotationAnimation.value * 2 * 3.14159,
                        child: SvgPicture.asset(
                          expandProgress > 0.5
                              ? 'assets/icons/close_linear.svg'
                              : 'assets/icons/nav_widget_bold.svg',
                          width: 24.w,
                          height: 24.w,
                          colorFilter: const ColorFilter.mode(
                            AppColors.primaryOlive,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Compact 4-icon tab bar with animated active indicator
  Widget _buildCompactTabs(NavigationController navCtrl) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
      child: Obx(() {
        final activeIndex = navCtrl.currentTabIndex.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabItem(
              index: 0,
              iconPath: 'assets/icons/nav_home_bold.svg',
              isActive: activeIndex == 0,
              onTap: () {
                navCtrl.switchTab(0);
                onTabSelected(0);
              },
            ),
            _buildTabItem(
              index: 1,
              iconPath: 'assets/icons/documents_bold.svg',
              isActive: activeIndex == 1,
              onTap: () {
                navCtrl.switchTab(1);
                onTabSelected(1);
              },
            ),
            _buildTabItem(
              index: 2,
              iconPath: 'assets/icons/nav_calendar_bold.svg',
              isActive: activeIndex == 2,
              onTap: () {
                navCtrl.switchTab(2);
                onTabSelected(2);
              },
            ),
            _buildTabItem(
              index: 3,
              iconPath: 'assets/icons/nav_wallet_bold.svg',
              isActive: activeIndex == 3,
              onTap: () {
                navCtrl.switchTab(3);
                onTabSelected(3);
              },
            ),
          ],
        );
      }),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String iconPath,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 240),
            curve: Curves.easeOutCubic,
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primaryOlive : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              iconPath,
              width: 22.w,
              height: 22.w,
              colorFilter: ColorFilter.mode(
                isActive ? Colors.white : const Color(0xFF767272),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Expanded Module Switching grid (Figma 66:4639)
  Widget _buildExpandedModules(
      NavigationController navCtrl, double expandProgress) {
    final opacity = ((expandProgress - 0.3) / 0.7).clamp(0.0, 1.0);

    return Opacity(
      opacity: opacity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Section 1: Student Activities
              Text(
                'Student Activities',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryOlive,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildModuleItem(
                    title: 'Leave',
                    iconPath: 'assets/icons/file_text_bold.svg',
                    onTap: () => _handleModuleTap(navCtrl, 'Leave'),
                  ),
                  _buildModuleItem(
                    title: 'My Classes',
                    iconPath: 'assets/icons/book_bookmark_bold.svg',
                    onTap: () => _handleModuleTap(navCtrl, 'My Classes'),
                  ),
                  _buildModuleItem(
                    title: 'Assessment',
                    iconPath: 'assets/icons/documents_bold.svg',
                    onTap: () => _handleModuleTap(navCtrl, 'Assessment'),
                  ),
                  _buildModuleItem(
                    title: 'Assignment',
                    iconPath: 'assets/icons/document_add_bold.svg',
                    onTap: () => _handleModuleTap(navCtrl, 'Assignment'),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Section 2: Teacher Activities
              Text(
                'Teacher Activities',
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryOlive,
                ),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildModuleItem(
                    title: 'Academic Calendar',
                    iconPath: 'assets/icons/calendar_bold.svg',
                    onTap: () =>
                        _handleModuleTap(navCtrl, 'Academic Calendar'),
                  ),
                  _buildModuleItem(
                    title: 'Circular',
                    iconPath: 'assets/icons/notes_bold.svg',
                    onTap: () => _handleModuleTap(navCtrl, 'Circular'),
                  ),
                  _buildModuleItem(
                    title: 'Teacher Leave',
                    iconPath: 'assets/icons/inbox_archive_bold.svg',
                    onTap: () => _handleModuleTap(navCtrl, 'Teacher Leave'),
                  ),
                  _buildModuleItem(
                    title: 'My Profile',
                    iconPath: 'assets/icons/documents_bold.svg',
                    isProfile: true,
                    onTap: () => _handleModuleTap(navCtrl, 'My Profile'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
    bool isProfile = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 58.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular action button (#424B0B)
            Container(
              width: 50.w,
              height: 50.w,
              decoration: const BoxDecoration(
                color: AppColors.primaryOlive,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: isProfile
                  ? ClipOval(
                      child: Image.asset(
                        'assets/images/student_avatar_main.png',
                        width: 50.w,
                        height: 50.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            SvgPicture.asset(
                          iconPath,
                          width: 22.w,
                          height: 22.w,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    )
                  : SvgPicture.asset(
                      iconPath,
                      width: 22.w,
                      height: 22.w,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
            SizedBox(height: 6.h),
            Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF767272),
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleModuleTap(NavigationController navCtrl, String moduleName) {
    navCtrl.closeModuleSheet();
    if (onModuleSelected != null) {
      onModuleSelected!(moduleName);
    } else {
      Get.snackbar(
        moduleName,
        'Opening $moduleName module...',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.white,
        colorText: AppColors.primaryOlive,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
      );
    }
  }
}
