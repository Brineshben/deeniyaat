import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:deeniyat/main.dart';
import 'package:deeniyat/routes/app_routes.dart';
import 'package:deeniyat/features/home/screens/home_screen.dart';
import 'package:deeniyat/features/attendance/screens/attendance_overview_screen.dart';
import 'package:deeniyat/features/attendance/screens/students_requiring_attention_screen.dart';
import 'package:deeniyat/features/attendance/screens/student_attendance_summary_screen.dart';
import 'package:deeniyat/features/attendance/screens/absent_and_leave_days_screen.dart';
import 'package:deeniyat/features/attendance/screens/attendance_overview_by_date_screen.dart';
import 'package:deeniyat/features/attendance/screens/select_class_screen.dart';
import 'package:deeniyat/features/attendance/screens/mark_attendance_screen.dart';
import 'package:deeniyat/features/attendance/widgets/attendance_confirmation_dialog.dart';
import 'package:deeniyat/features/attendance/controller/mark_attendance_controller.dart';
import 'package:deeniyat/features/timetable/screens/timetable_screen.dart';
import 'package:deeniyat/features/timetable/controller/timetable_controller.dart';
import 'package:deeniyat/features/navigation/controller/navigation_controller.dart';
import 'package:deeniyat/features/attendance/controller/attendance_controller.dart';

Widget _wrapWithScreenUtil(Widget child) {
  return ScreenUtilInit(
    designSize: const Size(390, 844),
    builder: (context, _) => GetMaterialApp(
      home: child,
    ),
  );
}

void main() {
  setUp(() {
    Get.reset();
  });

  testWidgets('1. HomeScreen renders with all cards and bottom nav bar',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const DeeniyatApp(initialRoute: AppRoutes.home));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Assalamu Alaikum'), findsOneWidget);
    expect(find.text('Class Summary'), findsOneWidget);
    expect(find.text('Attendance Summary Today'), findsOneWidget);
    expect(find.text('Fee Collection'), findsOneWidget);
    expect(find.text('Leave Overview'), findsOneWidget);
  });

  testWidgets('2. Bottom Navigation Bar expands to Module Switching & animates',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const DeeniyatApp(initialRoute: AppRoutes.home));
    await tester.pumpAndSettle();

    final navCtrl = Get.find<NavigationController>();
    expect(navCtrl.isModuleSheetOpen.value, isFalse);

    // Toggle module switcher
    navCtrl.openModuleSheet();
    await tester.pump(const Duration(milliseconds: 160));
    await tester.pumpAndSettle();

    expect(navCtrl.isModuleSheetOpen.value, isTrue);
    expect(find.text('Student Activities'), findsOneWidget);
    expect(find.text('Teacher Activities'), findsOneWidget);
    expect(find.text('Academic Calendar'), findsOneWidget);

    // Close module switcher
    navCtrl.closeModuleSheet();
    await tester.pumpAndSettle();
    expect(navCtrl.isModuleSheetOpen.value, isFalse);
  });

  testWidgets('3. AttendanceOverviewScreen renders successfully',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(NavigationController());
    Get.put(AttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const AttendanceOverviewScreen()));
    await tester.pumpAndSettle();

    expect(find.text(' Attendance Overview'), findsOneWidget);
    expect(find.text('Weekly Attendance Trend'), findsOneWidget);
    expect(find.text('Attendance Insight'), findsOneWidget);
    expect(find.text('View absentees data →'), findsOneWidget);
    expect(find.text('View leave data →'), findsOneWidget);
  });

  testWidgets('4. StudentsRequiringAttentionScreen renders successfully',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(AttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const StudentsRequiringAttentionScreen()));
    await tester.pumpAndSettle();

    expect(find.text(' 23 students requiring attention'), findsOneWidget);
    expect(find.text('Ahamed Ali Mohammed'), findsOneWidget);
    expect(find.text('23.7%'), findsOneWidget);
  });

  testWidgets('5. StudentAttendanceSummaryScreen renders successfully',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(AttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const StudentAttendanceSummaryScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Student Attendance Summary'), findsOneWidget);
    expect(find.text('Ahamed Ali Mohammed'), findsOneWidget);
    expect(find.text('Overall Attendance Performance'), findsOneWidget);
    expect(find.text('October 2026'), findsOneWidget);
    expect(find.text('Total working days: 24'), findsOneWidget);
  });

  testWidgets('6. AbsentAndLeaveDaysScreen renders successfully',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(AttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const AbsentAndLeaveDaysScreen()));
    await tester.pumpAndSettle();

    expect(find.text('absent & leave days'), findsOneWidget);
    expect(find.text('May 2026'), findsOneWidget);
    expect(find.text('06 May 2026, Wednesday'), findsOneWidget);
    expect(find.text('Sick Leave'), findsWidgets);
  });

  testWidgets('7. LoginScreen renders form inputs and button',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const DeeniyatApp());
    await tester.pumpAndSettle();

    expect(find.text('Welcome Back.'), findsOneWidget);
    expect(find.text('Empowering teachers, simplifying learning.'), findsOneWidget);
    expect(find.text('Email ID'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Keep me signed in'), findsOneWidget);
    expect(find.text('Forget Password?'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Deeniyat Teacher App V 1.01'), findsOneWidget);
  });

  testWidgets('8. TimetableScreen renders day pills and period cards',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(NavigationController());
    Get.put(TimetableController());

    await tester.pumpWidget(_wrapWithScreenUtil(const TimetableScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Timetable'), findsOneWidget);
    expect(find.text('Mon'), findsOneWidget);
    expect(find.text('Tue'), findsOneWidget);
    expect(find.text('Wed'), findsOneWidget);
    expect(find.text('After noon'), findsOneWidget);
    expect(find.text('Qur’an & Tajweed'), findsWidgets);
  });

  testWidgets('9. MarkAttendanceScreen renders student list and status selectors',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(MarkAttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const MarkAttendanceScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Mark attendance'), findsOneWidget);
    expect(find.text('Grade 2B'), findsOneWidget);
    expect(find.text('Search students'), findsOneWidget);
    expect(find.text('Mark all present'), findsOneWidget);
    expect(find.text('Submit Attendance'), findsOneWidget);
    expect(find.text('Ibrahim Noor'), findsWidgets);
  });

  testWidgets('10. AttendanceConfirmationDialog renders confirmation card and counts',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(MarkAttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const AttendanceConfirmationDialog()));
    await tester.pumpAndSettle();

    expect(find.text('Confirm today’s attendance?'), findsOneWidget);
    expect(find.text('Review the attendance before submitting.'), findsOneWidget);
    expect(find.text('21 August 2026, Monday'), findsOneWidget);
    expect(find.text('Confirm Submission'), findsOneWidget);
    expect(find.text('Back to Mark Attendance'), findsOneWidget);
  });

  testWidgets('11. SelectClassScreen renders class options',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(MarkAttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const SelectClassScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Select Grade'), findsOneWidget);
    expect(find.text('Grade 2B'), findsWidgets);
    expect(find.text('Grade 3A'), findsWidgets);
    expect(find.text('Grade 5C'), findsWidgets);
  });

  testWidgets('12. AttendanceOverviewByDateScreen renders summary and student list',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3.0;

    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    Get.put(AttendanceController());

    await tester.pumpWidget(_wrapWithScreenUtil(const AttendanceOverviewByDateScreen()));
    await tester.pumpAndSettle();

    expect(find.text('01 October 2026'), findsOneWidget);
    expect(find.text('Overall performance'), findsOneWidget);
    expect(find.text('22 Present'), findsOneWidget);
    expect(find.text('2 Early Arrivals'), findsOneWidget);
  });
}
