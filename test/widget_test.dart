import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:deeniyat/main.dart';
import 'package:deeniyat/features/home/screens/home_screen.dart';
import 'package:deeniyat/features/attendance/screens/attendance_overview_screen.dart';
import 'package:deeniyat/features/attendance/screens/students_requiring_attention_screen.dart';
import 'package:deeniyat/features/attendance/screens/student_attendance_summary_screen.dart';
import 'package:deeniyat/features/attendance/screens/absent_and_leave_days_screen.dart';
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

    await tester.pumpWidget(const DeeniyatApp());
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text('Assalamu Alaikum'), findsOneWidget);
    expect(find.text('Class Summary'), findsOneWidget);
    expect(find.text('Attendance Overview Today'), findsOneWidget);
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

    await tester.pumpWidget(const DeeniyatApp());
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
}
