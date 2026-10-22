import 'package:get/get.dart';
import '../features/home/screens/home_screen.dart';
import '../features/attendance/screens/attendance_overview_screen.dart';
import '../features/attendance/screens/students_requiring_attention_screen.dart';
import '../features/attendance/screens/student_attendance_summary_screen.dart';
import '../features/attendance/screens/absent_and_leave_days_screen.dart';

class AppRoutes {
  static const String initial = '/';
  static const String home = '/home';
  static const String attendanceOverview = '/attendance-overview';
  static const String studentsRequiringAttention = '/students-requiring-attention';
  static const String studentAttendanceSummary = '/student-attendance-summary';
  static const String absentAndLeaveDays = '/absent-and-leave-days';

  static final getPages = [
    GetPage(
      name: initial,
      page: () => const HomeScreen(),
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
  ];
}
