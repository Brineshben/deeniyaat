import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/utils/responsive.dart';
import '../../attendance/screens/attendance_overview_screen.dart';
import '../../navigation/controller/navigation_controller.dart';
import '../../navigation/widgets/animated_bottom_nav_bar.dart';
import '../controller/home_controller.dart';
import '../widgets/attendance_overview_card.dart';
import '../widgets/fee_collection_card.dart';
import '../widgets/grade_filter_chips.dart';
import '../widgets/home_header.dart';
import '../widgets/leave_overview_card.dart';
import '../widgets/summary_carousel_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final navCtrl = Get.put(NavigationController());

    return Scaffold(
      backgroundColor: const Color(0xFFEBF6D2),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background: Figma background image with fallback gradient
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
                  // Scrollable Body Content
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12.h),

                        // Header (Greeting, Title & Notification Bell)
                        HomeHeader(
                          onNotificationTap: controller.onNotificationPressed,
                        ),

                        SizedBox(height: 16.h),

                        // Top Carousel (Figma node 66:4489: Attendance & Timetable Cards)
                        Obx(
                          () => SummaryCarouselCard(
                            pageController: controller.carouselPageController,
                            activeIndex: controller.activeCarouselIndex.value,
                            onPageChanged: controller.onCarouselPageChanged,
                            onTakeAttendanceTap: () {
                              Get.to(
                                () => const AttendanceOverviewScreen(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 280),
                              );
                            },
                            onTimetableTap: controller.onTimetablePressed,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Grade Filter Chips (All Grades, Grade 2B, Grade 3B, etc.)
                        Obx(
                          () => GradeFilterChips(
                            grades: controller.grades,
                            selectedIndex: controller.selectedGradeIndex.value,
                            onGradeSelected: controller.onGradeSelected,
                          ),
                        ),

                        SizedBox(height: 12.h),

                        // Card 1: Attendance Overview Today (with 6-Day Mini Bar Chart)
                        Obx(() {
                          final data = controller.summaryData.value;
                          return AttendanceOverviewCard(
                            presentStudents: data.presentStudents,
                            totalStudents: data.totalStudents,
                            performancePercentage: data.attendancePerformance,
                            weeklyAttendance: data.weeklyAttendance,
                            onTap: () {
                              Get.to(
                                () => const AttendanceOverviewScreen(),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 280),
                              );
                            },
                          );
                        }),

                        SizedBox(height: 12.h),

                        // Card 2: Fee Collection Card (with 24-tick progress bar & breakdown)
                        Obx(() {
                          final data = controller.summaryData.value;
                          return FeeCollectionCard(
                            expectedAmount: data.feeExpected,
                            outstandingAmount: data.feeOutstanding,
                            outstandingStudentsCount:
                                data.feeOutstandingStudents,
                            collectedPercentage: data.feeCollectedPercent,
                            pendingAmount: data.feePending,
                            duesAmount: data.feeDues,
                            arrearsAmount: data.feeArrears,
                            totalTicks: data.feeTotalTicks,
                            unpaidTicks: data.feeUnpaidTicks,
                            onViewInsights: controller.onViewFeeInsightsPressed,
                          );
                        }),

                        SizedBox(height: 12.h),

                        // Card 3: Leave Overview Card (with Avatar Stack & Gradient Strip)
                        Obx(() {
                          final data = controller.summaryData.value;
                          return LeaveOverviewCard(
                            studentsOnLeave: data.studentsOnLeave,
                            leaveDescription: data.leaveDescription,
                            pendingRequestsCount: data.pendingLeaveRequests,
                            onViewLeaves: controller.onViewLeavesPressed,
                          );
                        }),

                        // Bottom spacing to prevent floating navbar from obscuring content
                        SizedBox(height: 90.h),
                      ],
                    ),
                  ),

                  // Dim overlay when module sheet is expanded
                  Obx(() {
                    if (!navCtrl.isModuleSheetOpen.value) {
                      return const SizedBox.shrink();
                    }
                    return Positioned.fill(
                      child: GestureDetector(
                        onTap: navCtrl.closeModuleSheet,
                        child: Container(
                          color: Colors.black.withValues(alpha: 0.15),
                        ),
                      ),
                    );
                  }),

                  // Floating Animated Bottom Navigation Bar (Figma navbar 66:4638 <-> 66:4639)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20.h,
                    child: AnimatedBottomNavBar(
                      onTabSelected: (index) {
                        if (index == 1) {
                          Get.to(
                            () => const AttendanceOverviewScreen(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 280),
                          );
                        } else if (index != 0) {
                          controller.onNavItemSelected(index);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
