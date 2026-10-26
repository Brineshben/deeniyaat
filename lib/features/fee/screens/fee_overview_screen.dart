import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../routes/app_routes.dart';
import '../../navigation/widgets/animated_bottom_nav_bar.dart';
import '../controller/fee_controller.dart';
import '../widgets/fee_summary_card.dart';
import '../widgets/student_fee_item_card.dart';

class FeeOverviewScreen extends StatelessWidget {
  const FeeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeeController());

    return Scaffold(
      backgroundColor: const Color(0xFFEBF6D2),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with gradient fallback
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
                      _buildHeader(context, controller),
                      SizedBox(height: 10.h),

                      // Grade Filter Pills
                      _buildGradeFilterPills(controller),
                      SizedBox(height: 12.h),

                      // Outstanding Balance Summary Card
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: FeeSummaryCard(
                          outstandingBalance: controller.outstandingBalance,
                          fromStudentsCount: controller.outstandingStudentsCount,
                          totalPayable: controller.totalPayable,
                          totalCollected: controller.totalCollected,
                          progressFraction: controller.progressFraction,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      // Status Chips
                      _buildStatusFilterChips(controller),
                      SizedBox(height: 10.h),

                      // Search Input
                      _buildSearchBar(controller),
                      SizedBox(height: 10.h),

                      // Student Fee List
                      Expanded(
                        child: Obx(() {
                          final students = controller.filteredStudents;
                          return ListView.builder(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              bottom: 100.h, // Bottom spacing for navbar
                            ),
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              final student = students[index];
                              return StudentFeeItemCard(
                                student: student,
                                onTap: () {
                                  controller.selectedStudent.value = student;
                                  Get.toNamed(AppRoutes.feeStudentOverview);
                                },
                              );
                            },
                          );
                        }),
                      ),
                    ],
                  ),

                  // Floating Animated Bottom Navigation Bar
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20.h,
                    child: const AnimatedBottomNavBar(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, FeeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Fee Overview',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryOlive,
              letterSpacing: -0.5,
            ),
          ),
          // History Button
          GestureDetector(
            onTap: () => controller.showCollectionHistorySheet(context),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/icon_history.svg',
                width: 20.w,
                height: 20.w,
                colorFilter: const ColorFilter.mode(
                  AppColors.primaryOlive,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradeFilterPills(FeeController controller) {
    return SizedBox(
      height: 32.h,
      child: Obx(() {
        final selected = controller.selectedGrade.value;
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scrollDirection: Axis.horizontal,
          children: controller.gradesList.map((grade) {
            final isSelected = selected == grade;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () => controller.selectedGrade.value = grade,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryOlive
                        : Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    grade,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.primaryOlive,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }

  Widget _buildStatusFilterChips(FeeController controller) {
    return SizedBox(
      height: 32.h,
      child: Obx(() {
        final selected = controller.selectedStatusFilter.value;
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          scrollDirection: Axis.horizontal,
          children: controller.statusFilters.map((filter) {
            final isSelected = selected == filter;
            return Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: GestureDetector(
                onTap: () => controller.selectedStatusFilter.value = filter,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryOlive
                        : Colors.white.withValues(alpha: 0.85),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Text(
                    filter,
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : AppColors.primaryOlive,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      }),
    );
  }

  Widget _buildSearchBar(FeeController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        height: 44.h,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/search_linear.svg',
              width: 16.w,
              height: 16.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF767272),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: TextField(
                controller: controller.searchController,
                onChanged: (val) => controller.searchQuery.value = val,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  fontSize: 12.sp,
                  color: AppColors.primaryOlive,
                ),
                decoration: InputDecoration(
                  hintText: 'Search students',
                  hintStyle: TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 12.sp,
                    color: const Color(0xFF767272),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
