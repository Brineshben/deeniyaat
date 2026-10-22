import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/home_data_model.dart';

class HomeController extends GetxController {
  final RxBool isLoading = false.obs;

  // Carousel
  final RxInt activeCarouselIndex = 0.obs;
  late final PageController carouselPageController;

  // Grade filter
  final RxInt selectedGradeIndex = 0.obs;
  final List<String> grades = const [
    'All Grades',
    'Grade 2B',
    'Grade 3B',
    'Grade 3A',
    'Grade 5C',
    'Grade 1A',
  ];

  // Bottom Navigation
  final RxInt selectedNavIndex = 0.obs;

  // Home Screen Data
  final Rx<HomeSummaryData> summaryData = const HomeSummaryData(
    presentStudents: 22,
    totalStudents: 24,
    attendancePerformance: 94,
    weeklyAttendance: [
      DayAttendanceModel(day: 'M', isCompleted: true),
      DayAttendanceModel(day: 'T', isCompleted: true),
      DayAttendanceModel(day: 'W', isCompleted: true, isToday: true),
      DayAttendanceModel(day: 'T', isFuture: true),
      DayAttendanceModel(day: 'F', isFuture: true),
      DayAttendanceModel(day: 'S', isFuture: true),
    ],
    feeExpected: '₹50,000',
    feeOutstanding: '₹50,000',
    feeOutstandingStudents: 3,
    feeCollectedPercent: 78,
    feePending: '₹39,000',
    feeDues: '₹39,000',
    feeArrears: '₹39,000',
    feeTotalTicks: 24,
    feeUnpaidTicks: 7,
    studentsOnLeave: 22,
    leaveDescription: 'Most leaves are of sick leave',
    pendingLeaveRequests: 2,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    carouselPageController = PageController(viewportFraction: 0.92);
  }

  @override
  void onClose() {
    carouselPageController.dispose();
    super.onClose();
  }

  void onCarouselPageChanged(int index) {
    activeCarouselIndex.value = index;
  }

  void onGradeSelected(int index) {
    selectedGradeIndex.value = index;
  }

  void onNavItemSelected(int index) {
    selectedNavIndex.value = index;
  }

  void onNotificationPressed() {
    Get.snackbar(
      'Notifications',
      'No new notifications',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      colorText: const Color(0xFF424B0B),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  void onTakeAttendancePressed() {
    Get.snackbar(
      'Attendance',
      'Opening attendance sheet for Grade 2B',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      colorText: const Color(0xFF424B0B),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  void onTimetablePressed() {
    Get.snackbar(
      'Next Class',
      'Qur’an & Tajweed (10:00 am–10:45 am)',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      colorText: const Color(0xFF424B0B),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  void onViewFeeInsightsPressed() {
    Get.snackbar(
      'Fee Collection',
      'Navigating to Fee Insights',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      colorText: const Color(0xFF424B0B),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  void onViewLeavesPressed() {
    Get.snackbar(
      'Leave Requests',
      'Navigating to Leave Requests',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      colorText: const Color(0xFF424B0B),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }

  void onMenuWidgetPressed() {
    Get.snackbar(
      'Menu',
      'Quick action menu opened',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
      colorText: const Color(0xFF424B0B),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
  }
}
