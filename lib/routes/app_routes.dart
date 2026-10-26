import 'package:get/get.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/attendance/screens/attendance_overview_screen.dart';
import '../features/attendance/screens/students_requiring_attention_screen.dart';
import '../features/attendance/screens/student_attendance_summary_screen.dart';
import '../features/attendance/screens/absent_and_leave_days_screen.dart';
import '../features/attendance/screens/attendance_overview_by_date_screen.dart';
import '../features/attendance/screens/select_class_screen.dart';
import '../features/attendance/screens/mark_attendance_screen.dart';
import '../features/timetable/screens/timetable_screen.dart';
import '../features/fee/controller/fee_controller.dart';
import '../features/fee/screens/fee_overview_screen.dart';
import '../features/fee/screens/fee_student_overview_screen.dart';
import '../features/profile/screens/profile_screen.dart';

class AppRoutes {
  static const String initial = '/login';
  static const String login = '/login';
  static const String home = '/home';
  static const String attendanceOverview = '/attendance-overview';
  static const String studentsRequiringAttention = '/students-requiring-attention';
  static const String studentAttendanceSummary = '/student-attendance-summary';
  static const String absentAndLeaveDays = '/absent-and-leave-days';
  static const String attendanceOverviewByDate = '/attendance-overview-by-date';
  static const String selectClass = '/select-class';
  static const String markAttendance = '/mark-attendance';
  static const String timetable = '/timetable';
  static const String feeOverview = '/fee-overview';
  static const String feeStudentOverview = '/fee-student-overview';
  static const String profile = '/profile';

  static final getPages = [
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: attendanceOverview,
      page: () => const AttendanceOverviewScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: studentsRequiringAttention,
      page: () => const StudentsRequiringAttentionScreen(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: studentAttendanceSummary,
      page: () => const StudentAttendanceSummaryScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: absentAndLeaveDays,
      page: () => const AbsentAndLeaveDaysScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: attendanceOverviewByDate,
      page: () => const AttendanceOverviewByDateScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: selectClass,
      page: () => const SelectClassScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: markAttendance,
      page: () => const MarkAttendanceScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: timetable,
      page: () => const TimetableScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: feeOverview,
      page: () => const FeeOverviewScreen(),
      transition: Transition.fadeIn,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<FeeController>()) {
          Get.put(FeeController());
        }
      }),
    ),
    GetPage(
      name: feeStudentOverview,
      page: () => const FeeStudentOverviewScreen(),
      transition: Transition.rightToLeft,
      binding: BindingsBuilder(() {
        if (!Get.isRegistered<FeeController>()) {
          Get.put(FeeController());
        }
      }),
    ),
    GetPage(
      name: profile,
      page: () => const ProfileScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
