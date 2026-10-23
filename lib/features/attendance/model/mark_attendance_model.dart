enum StudentMarkStatus {
  earlyArrival,
  present,
  absent,
  late,
  onLeave,
}

class StudentAttendanceItemModel {
  final String id;
  final String name;
  final String rollNo;
  final String avatarUrl;
  StudentMarkStatus status;
  final bool isOnLeave;

  StudentAttendanceItemModel({
    required this.id,
    required this.name,
    required this.rollNo,
    required this.avatarUrl,
    this.status = StudentMarkStatus.present,
    this.isOnLeave = false,
  });

  StudentAttendanceItemModel copyWith({
    String? id,
    String? name,
    String? rollNo,
    String? avatarUrl,
    StudentMarkStatus? status,
    bool? isOnLeave,
  }) {
    return StudentAttendanceItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      rollNo: rollNo ?? this.rollNo,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      status: status ?? this.status,
      isOnLeave: isOnLeave ?? this.isOnLeave,
    );
  }
}

class ClassGradeOptionModel {
  final String grade;
  final String time;
  final String bgImage;

  const ClassGradeOptionModel({
    required this.grade,
    required this.time,
    required this.bgImage,
  });
}
