import 'package:get/get.dart';
import '../model/attendance_model.dart';

class AttendanceController extends GetxController {
  final RxInt selectedGradeIndex = 0.obs;
  final RxInt selectedMonthIndex = 4.obs; // May 2026

  final List<String> grades = const [
    'All Grades',
    'Grade 2B',
    'Grade 3B',
    'Grade 3A',
    'Grade 5C',
    'Grade 1A',
  ];

  final List<String> months = const [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
  ];

  // Selected student
  late final Rx<StudentAttentionModel> selectedStudent;

  // Students requiring critical attention (< 40%)
  final RxList<StudentAttentionModel> criticalStudents = <StudentAttentionModel>[
    const StudentAttentionModel(
      id: '1',
      name: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      rollNo: 'Roll No:04',
      attendancePercentage: 23.7,
      avatarPath: 'assets/images/student_avatar_main.png',
    ),
    const StudentAttentionModel(
      id: '2',
      name: 'Mohammed Zayd',
      grade: 'Grade 2 B',
      rollNo: 'Roll No:08',
      attendancePercentage: 28.5,
      avatarPath: 'assets/images/student_avatar_1.png',
    ),
    const StudentAttentionModel(
      id: '3',
      name: 'Ibrahim Khalil',
      grade: 'Grade 2 B',
      rollNo: 'Roll No:12',
      attendancePercentage: 31.2,
      avatarPath: 'assets/images/student_avatar_2.png',
    ),
    const StudentAttentionModel(
      id: '4',
      name: 'Umar Farooq',
      grade: 'Grade 2 B',
      rollNo: 'Roll No:17',
      attendancePercentage: 34.0,
      avatarPath: 'assets/images/student_avatar_3.png',
    ),
    const StudentAttentionModel(
      id: '5',
      name: 'Hamza Bilal',
      grade: 'Grade 2 B',
      rollNo: 'Roll No:21',
      attendancePercentage: 38.4,
      avatarPath: 'assets/images/student_avatar_4.png',
    ),
  ].obs;

  // Monthly summary for Student Attendance Summary (October 2026)
  final Rx<MonthSummaryModel> octoberSummary = const MonthSummaryModel(
    monthTitle: 'October 2026',
    totalWorkingDays: 24,
    presentCount: 20,
    absentCount: 4,
    lateCount: 1,
    leaveCount: 1,
    overallPercentage: 23.7,
    dailyRecords: [
      DayAttendanceRecord(
        dayNumber: 1,
        dateFormatted: '01 Oct 2026, Thursday',
        status: AttendanceStatus.present,
      ),
      DayAttendanceRecord(
        dayNumber: 2,
        dateFormatted: '02 Oct 2026, Friday',
        status: AttendanceStatus.absent,
      ),
      DayAttendanceRecord(
        dayNumber: 3,
        dateFormatted: '03 Oct 2026, Saturday',
        status: AttendanceStatus.off,
      ),
      DayAttendanceRecord(
        dayNumber: 4,
        dateFormatted: '04 Oct 2026, Sunday',
        status: AttendanceStatus.off,
      ),
      DayAttendanceRecord(
        dayNumber: 5,
        dateFormatted: '05 Oct 2026, Monday',
        status: AttendanceStatus.present,
      ),
      DayAttendanceRecord(
        dayNumber: 6,
        dateFormatted: '06 Oct 2026, Tuesday',
        status: AttendanceStatus.present,
      ),
      DayAttendanceRecord(
        dayNumber: 7,
        dateFormatted: '07 Oct 2026, Wednesday',
        status: AttendanceStatus.late,
      ),
      DayAttendanceRecord(
        dayNumber: 8,
        dateFormatted: '08 Oct 2026, Thursday',
        status: AttendanceStatus.present,
      ),
      DayAttendanceRecord(
        dayNumber: 9,
        dateFormatted: '09 Oct 2026, Friday',
        status: AttendanceStatus.absent,
      ),
      DayAttendanceRecord(
        dayNumber: 10,
        dateFormatted: '10 Oct 2026, Saturday',
        status: AttendanceStatus.off,
      ),
      DayAttendanceRecord(
        dayNumber: 11,
        dateFormatted: '11 Oct 2026, Sunday',
        status: AttendanceStatus.off,
      ),
      DayAttendanceRecord(
        dayNumber: 12,
        dateFormatted: '12 Oct 2026, Monday',
        status: AttendanceStatus.present,
      ),
      DayAttendanceRecord(
        dayNumber: 13,
        dateFormatted: '13 Oct 2026, Tuesday',
        status: AttendanceStatus.leave,
        leaveReason: 'Sick Leave',
      ),
      DayAttendanceRecord(
        dayNumber: 14,
        dateFormatted: '14 Oct 2026, Wednesday',
        status: AttendanceStatus.present,
      ),
    ],
  ).obs;

  // Absent & Leave Records for May 2026
  final RxList<DayAttendanceRecord> mayAbsentLeaveDays = <DayAttendanceRecord>[
    const DayAttendanceRecord(
      dayNumber: 6,
      dateFormatted: '06 May 2026, Wednesday',
      status: AttendanceStatus.absent,
    ),
    const DayAttendanceRecord(
      dayNumber: 7,
      dateFormatted: '07 May 2026, Thursday',
      status: AttendanceStatus.leave,
      leaveReason: 'Sick Leave',
    ),
    const DayAttendanceRecord(
      dayNumber: 8,
      dateFormatted: '08 May 2026, Friday',
      status: AttendanceStatus.leave,
      leaveReason: 'Sick Leave',
    ),
    const DayAttendanceRecord(
      dayNumber: 13,
      dateFormatted: '13 May 2026, Wednesday',
      status: AttendanceStatus.absent,
    ),
    const DayAttendanceRecord(
      dayNumber: 22,
      dateFormatted: '22 May 2026, Wednesday',
      status: AttendanceStatus.absent,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    selectedStudent = criticalStudents.first.obs;
  }

  void selectGrade(int index) {
    selectedGradeIndex.value = index;
  }

  void selectMonth(int index) {
    selectedMonthIndex.value = index;
  }

  void selectStudent(StudentAttentionModel student) {
    selectedStudent.value = student;
  }
}
