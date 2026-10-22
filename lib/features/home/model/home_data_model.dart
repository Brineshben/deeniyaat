class DayAttendanceModel {
  final String day;
  final bool isCompleted;
  final bool isToday;
  final bool isFuture;

  const DayAttendanceModel({
    required this.day,
    this.isCompleted = false,
    this.isToday = false,
    this.isFuture = false,
  });
}

class GradeModel {
  final String id;
  final String name;

  const GradeModel({
    required this.id,
    required this.name,
  });
}

class HomeSummaryData {
  final int presentStudents;
  final int totalStudents;
  final int attendancePerformance;
  final List<DayAttendanceModel> weeklyAttendance;

  final String feeExpected;
  final String feeOutstanding;
  final int feeOutstandingStudents;
  final int feeCollectedPercent;
  final String feePending;
  final String feeDues;
  final String feeArrears;
  final int feeTotalTicks;
  final int feeUnpaidTicks;

  final int studentsOnLeave;
  final String leaveDescription;
  final int pendingLeaveRequests;

  const HomeSummaryData({
    required this.presentStudents,
    required this.totalStudents,
    required this.attendancePerformance,
    required this.weeklyAttendance,
    required this.feeExpected,
    required this.feeOutstanding,
    required this.feeOutstandingStudents,
    required this.feeCollectedPercent,
    required this.feePending,
    required this.feeDues,
    required this.feeArrears,
    this.feeTotalTicks = 24,
    this.feeUnpaidTicks = 7,
    required this.studentsOnLeave,
    required this.leaveDescription,
    required this.pendingLeaveRequests,
  });
}
