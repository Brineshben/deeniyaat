import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/mark_attendance_model.dart';

class MarkAttendanceController extends GetxController {
  final RxString selectedGrade = 'Grade 2B'.obs;
  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final RxList<ClassGradeOptionModel> gradeOptions = <ClassGradeOptionModel>[
    const ClassGradeOptionModel(
      grade: 'Grade 2B',
      time: '10:00 am–10:45 am',
      bgImage: 'assets/images/class_card_bg_1.png',
    ),
    const ClassGradeOptionModel(
      grade: 'Grade 3A',
      time: '11:00 am–11:45 am',
      bgImage: 'assets/images/class_card_bg_2.png',
    ),
    const ClassGradeOptionModel(
      grade: 'Grade 5C',
      time: '01:30 pm–02:15 pm',
      bgImage: 'assets/images/class_card_bg_3.png',
    ),
  ].obs;

  final RxList<StudentAttendanceItemModel> allStudents = <StudentAttendanceItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initStudents();
  }

  void _initStudents() {
    final List<Map<String, dynamic>> rawData = [
      {'name': 'Ibrahim Noor', 'roll': '01', 'status': StudentMarkStatus.earlyArrival},
      {'name': 'Ahamed Ali Mohammed', 'roll': '02', 'status': StudentMarkStatus.present},
      {'name': 'Zayan Farooq', 'roll': '03', 'status': StudentMarkStatus.present},
      {'name': 'Bilal Siddiqui', 'roll': '04', 'status': StudentMarkStatus.absent},
      {'name': 'Hamza Tariq', 'roll': '05', 'status': StudentMarkStatus.late},
      {'name': 'Mustafa Khan', 'roll': '06', 'status': StudentMarkStatus.onLeave, 'leave': true},
      {'name': 'Yusuf Rehman', 'roll': '07', 'status': StudentMarkStatus.present},
      {'name': 'Umar Farooq', 'roll': '08', 'status': StudentMarkStatus.earlyArrival},
      {'name': 'Sulaiman Dawood', 'roll': '09', 'status': StudentMarkStatus.present},
      {'name': 'Rayyan Malik', 'roll': '10', 'status': StudentMarkStatus.present},
      {'name': 'Idris Mansoor', 'roll': '11', 'status': StudentMarkStatus.absent},
      {'name': 'Kareem Abdullah', 'roll': '12', 'status': StudentMarkStatus.present},
      {'name': 'Taha Qureshi', 'roll': '13', 'status': StudentMarkStatus.present},
      {'name': 'Zubair Qasim', 'roll': '14', 'status': StudentMarkStatus.late},
      {'name': 'Arham Jameel', 'roll': '15', 'status': StudentMarkStatus.present},
      {'name': 'Farhan Nazeer', 'roll': '16', 'status': StudentMarkStatus.present},
      {'name': 'Nabeel Shafi', 'roll': '17', 'status': StudentMarkStatus.present},
      {'name': 'Adil Mehmood', 'roll': '18', 'status': StudentMarkStatus.present},
      {'name': 'Fahad Rashid', 'roll': '19', 'status': StudentMarkStatus.earlyArrival},
      {'name': 'Hassan Rizwan', 'roll': '20', 'status': StudentMarkStatus.present},
      {'name': 'Luqman Hakim', 'roll': '21', 'status': StudentMarkStatus.present},
      {'name': 'Yahya Siraj', 'roll': '22', 'status': StudentMarkStatus.absent},
      {'name': 'Daniyal Ashraf', 'roll': '23', 'status': StudentMarkStatus.present},
      {'name': 'Haroon Saeed', 'roll': '24', 'status': StudentMarkStatus.present},
    ];

    final avatarList = [
      'assets/images/student_avatar_main.png',
      'assets/images/student_avatar_1.png',
      'assets/images/student_avatar_2.png',
      'assets/images/student_avatar_3.png',
      'assets/images/student_avatar_4.png',
      'assets/images/student_avatar_5.png',
    ];

    allStudents.value = rawData.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      return StudentAttendanceItemModel(
        id: 'std_${index + 1}',
        name: item['name'] as String,
        rollNo: 'Roll ${item['roll']}',
        avatarUrl: avatarList[index % avatarList.length],
        status: item['status'] as StudentMarkStatus,
        isOnLeave: item['leave'] == true,
      );
    }).toList();
  }

  List<StudentAttendanceItemModel> get filteredStudents {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return allStudents;
    return allStudents.where((s) {
      return s.name.toLowerCase().contains(q) || s.rollNo.toLowerCase().contains(q);
    }).toList();
  }

  void updateStudentStatus(String id, StudentMarkStatus newStatus) {
    final index = allStudents.indexWhere((s) => s.id == id);
    if (index != -1) {
      final student = allStudents[index];
      if (student.isOnLeave) return; // Leave is locked
      student.status = newStatus;
      allStudents.refresh();
    }
  }

  void markAllPresent() {
    for (final s in allStudents) {
      if (!s.isOnLeave) {
        s.status = StudentMarkStatus.present;
      }
    }
    allStudents.refresh();
  }

  int get earlyArrivalCount =>
      allStudents.where((s) => s.status == StudentMarkStatus.earlyArrival).length;

  int get presentCount =>
      allStudents.where((s) => s.status == StudentMarkStatus.present).length;

  int get absentCount =>
      allStudents.where((s) => s.status == StudentMarkStatus.absent).length;

  int get lateCount =>
      allStudents.where((s) => s.status == StudentMarkStatus.late).length;

  int get totalCount => allStudents.length;

  void selectGrade(String grade) {
    selectedGrade.value = grade;
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
