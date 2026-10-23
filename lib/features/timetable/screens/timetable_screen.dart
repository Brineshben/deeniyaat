import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../../navigation/widgets/animated_bottom_nav_bar.dart';
import '../controller/timetable_controller.dart';
import '../widgets/timetable_period_card.dart';

class TimetableScreen extends StatelessWidget {
  const TimetableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TimetableController());
    final navController = Get.find<NavigationController>();
    navController.switchTab(2); // Timetable tab

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/home_screen_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main Content
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black.withValues(alpha: 0.06),
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/arrow_left_linear.svg',
                              width: 18.w,
                              height: 18.h,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primaryOlive,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Text(
                        'Timetable',
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryOlive,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 8.h),

                // Day Selector Chips (Mon, Tue, Wed, Thu, Fri)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Obx(
                    () => Row(
                      children: List.generate(
                        controller.weekDays.length,
                        (index) {
                          final isSelected =
                              controller.selectedDayIndex.value == index;
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.w),
                              child: GestureDetector(
                                onTap: () => controller.selectDay(index),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  padding: EdgeInsets.symmetric(
                                    vertical: 9.h,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primaryOlive
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(46.r),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primaryOlive
                                          : Colors.black.withValues(alpha: 0.06),
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: AppColors.primaryOlive
                                                  .withValues(alpha: 0.2),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Text(
                                    controller.weekDays[index],
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.primaryOlive,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // Period List ScrollView
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: 120.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Morning Periods
                        Obx(
                          () => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.morningPeriods.length,
                            separatorBuilder: (context, index) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              return TimetablePeriodCard(
                                period: controller.morningPeriods[index],
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 18.h),

                        // "After noon" Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: AppColors.primaryOlive
                                    .withValues(alpha: 0.25),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.w),
                              child: Text(
                                'After noon',
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.subtitleOlive,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: AppColors.primaryOlive
                                    .withValues(alpha: 0.25),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 18.h),

                        // Afternoon Periods
                        Obx(
                          () => ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.afternoonPeriods.length,
                            separatorBuilder: (context, index) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              return TimetablePeriodCard(
                                period: controller.afternoonPeriods[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dim Overlay when Module Switching is expanded
          Obx(() {
            if (!navController.isModuleSheetOpen.value) {
              return const SizedBox.shrink();
            }
            return Positioned.fill(
              child: GestureDetector(
                onTap: navController.toggleModuleSheet,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            );
          }),

          // Animated Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const AnimatedBottomNavBar(),
          ),
        ],
      ),
    );
  }
}
