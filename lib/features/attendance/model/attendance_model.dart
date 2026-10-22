enum AttendanceStatus {
  present,
  absent,
  late,
  leave,
  off,
}

class StudentAttentionModel {
  final String id;
  final String name;
  final String grade;
  final String rollNo;
  final double attendancePercentage;
  final String avatarPath;

  const StudentAttentionModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.rollNo,
    required this.attendancePercentage,
    required this.avatarPath,
  });
}

class DayAttendanceRecord {
  final int dayNumber;
  final String dateFormatted;
  final AttendanceStatus status;
  final String? leaveReason;

  const DayAttendanceRecord({
    required this.dayNumber,
    required this.dateFormatted,
    required this.status,
    this.leaveReason,
  });
}

class MonthSummaryModel {
  final String monthTitle;
  final int totalWorkingDays;
  final int presentCount;
  final int absentCount;
  final int lateCount;
  final int leaveCount;
  final double overallPercentage;
  final List<DayAttendanceRecord> dailyRecords;

  const MonthSummaryModel({
    required this.monthTitle,
    required this.totalWorkingDays,
    required this.presentCount,
    required this.absentCount,
    required this.lateCount,
    required this.leaveCount,
    required this.overallPercentage,
    required this.dailyRecords,
  });
}
