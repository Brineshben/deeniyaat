import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/fee_model.dart';
import '../widgets/collection_history_sheet.dart';
import '../widgets/student_collection_history_sheet.dart';
import '../widgets/collection_summary_sheet.dart';
import '../widgets/collect_fees_sheet.dart';
import '../widgets/fee_collection_success_dialog.dart';

class FeeController extends GetxController {
  // Grade Filter
  final RxString selectedGrade = 'All Grades'.obs;
  final List<String> gradesList = [
    'All Grades',
    'Grade 2B',
    'Grade 3B',
    'Grade 3A',
    'Grade 5C',
    'Grade 1A',
  ];

  // Status Filter for Overview Screen
  final RxString selectedStatusFilter = 'All 24'.obs;
  final List<String> statusFilters = [
    'All 24',
    'Arrears 12',
    'Dues 12',
    'Pending',
    'Fully Paid',
  ];

  // Status Filter for Student Detail Screen
  final RxString selectedStudentStatusFilter = 'All'.obs;
  final List<String> studentStatusFilters = [
    'All',
    'Arrears',
    'Dues',
    'Pending',
    'Paid',
  ];

  // Month filter for Student Collection History
  final RxString selectedMonth = 'Apr'.obs;
  final List<String> monthsList = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
  ];

  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // Selected Student
  final Rx<StudentFeeItem?> selectedStudent = Rx<StudentFeeItem?>(null);

  // Collect Fees State
  final RxInt collectFeesTab = 0.obs; // 0: Choose Fees, 1: Auto Distribute
  final RxString paymentMode = 'Cash'.obs; // 'Cash', 'Card', 'UPI'
  final TextEditingController autoAmountController = TextEditingController();

  // Overview Stats
  final String outstandingBalance = '₹50,000';
  final int outstandingStudentsCount = 3;
  final String totalPayable = '₹ 62,943';
  final String totalCollected = '₹ 42,943';
  final double progressFraction = 0.55;

  // Student list
  final RxList<StudentFeeItem> allStudents = <StudentFeeItem>[
    const StudentFeeItem(
      id: '1',
      name: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      rollNo: '04',
      avatarPath: 'assets/images/student_avatar_main.png',
      amountDue: 62943,
      isFullyPaid: false,
      arrearsCount: 1,
      duesCount: 1,
      status: 'Arrear',
    ),
    const StudentFeeItem(
      id: '2',
      name: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      rollNo: '04',
      avatarPath: 'assets/images/student_avatar_1.png',
      amountDue: 0,
      isFullyPaid: true,
      arrearsCount: 0,
      duesCount: 0,
      status: 'Fully Paid',
    ),
    const StudentFeeItem(
      id: '3',
      name: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      rollNo: '04',
      avatarPath: 'assets/images/student_avatar_2.png',
      amountDue: 62943,
      isFullyPaid: false,
      arrearsCount: 2,
      duesCount: 0,
      status: 'Arrear',
    ),
    const StudentFeeItem(
      id: '4',
      name: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      rollNo: '04',
      avatarPath: 'assets/images/student_avatar_3.png',
      amountDue: 62943,
      isFullyPaid: false,
      arrearsCount: 0,
      duesCount: 2,
      status: 'Due',
    ),
    const StudentFeeItem(
      id: '5',
      name: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      rollNo: '04',
      avatarPath: 'assets/images/student_avatar_4.png',
      amountDue: 0,
      isFullyPaid: true,
      arrearsCount: 0,
      duesCount: 0,
      status: 'Fully Paid',
    ),
    const StudentFeeItem(
      id: '6',
      name: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      rollNo: '04',
      avatarPath: 'assets/images/student_avatar_5.png',
      amountDue: 62943,
      isFullyPaid: false,
      arrearsCount: 1,
      duesCount: 0,
      status: 'Pending',
    ),
  ].obs;

  // Student specific fees breakdown
  final RxList<FeeItemDetail> studentFeeItems = <FeeItemDetail>[
    FeeItemDetail(
      id: 'f1',
      title: 'Exam Fee',
      term: 'Term I',
      type: 'Arrear',
      dateText: 'Due on 04 Dec 2025',
      amount: 2943,
      isPaid: false,
      isSelected: true,
    ),
    FeeItemDetail(
      id: 'f2',
      title: 'Exam Fee',
      term: 'Term I',
      type: 'Paid',
      dateText: 'Paid On 04 Sep 2026, 01:32 PM',
      amount: 2943,
      isPaid: true,
    ),
    FeeItemDetail(
      id: 'f3',
      title: 'Exam Fee',
      term: 'Term I',
      type: 'Arrear',
      dateText: 'Due on 04 Dec 2025',
      amount: 2943,
      isPaid: false,
      isSelected: true,
    ),
    FeeItemDetail(
      id: 'f4',
      title: 'Exam Fee',
      term: 'Term I',
      type: 'Paid',
      dateText: 'Paid On 04 Sep 2026, 01:32 PM',
      amount: 2943,
      isPaid: true,
    ),
    FeeItemDetail(
      id: 'f5',
      title: 'Exam Fee',
      term: 'Term II',
      type: 'Arrear',
      dateText: 'Due on 04 Dec 2025',
      amount: 2943,
      isPaid: false,
      isSelected: true,
    ),
    FeeItemDetail(
      id: 'f6',
      title: 'Exam Fee',
      term: 'Term II',
      type: 'Arrear',
      dateText: 'Due on 04 Dec 2025',
      amount: 2943,
      isPaid: false,
      isSelected: false,
    ),
  ].obs;

  // Collection History List
  final List<CollectionHistoryReceipt> collectionHistory = [
    const CollectionHistoryReceipt(
      id: 'h1',
      studentName: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      receiptNo: 'RCP-2308',
      avatarPath: 'assets/images/student_avatar_main.png',
      amount: 62943,
      dateGroup: 'Today',
      time: '12:34 PM',
    ),
    const CollectionHistoryReceipt(
      id: 'h2',
      studentName: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      receiptNo: 'RCP-2308',
      avatarPath: 'assets/images/student_avatar_1.png',
      amount: 62943,
      dateGroup: 'Today',
      time: '11:15 AM',
    ),
    const CollectionHistoryReceipt(
      id: 'h3',
      studentName: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      receiptNo: 'RCP-2308',
      avatarPath: 'assets/images/student_avatar_2.png',
      amount: 62943,
      dateGroup: 'Today',
      time: '09:45 AM',
    ),
    const CollectionHistoryReceipt(
      id: 'h4',
      studentName: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      receiptNo: 'RCP-2308',
      avatarPath: 'assets/images/student_avatar_3.png',
      amount: 62943,
      dateGroup: '22 Oct 26, Mon',
      time: '03:20 PM',
    ),
    const CollectionHistoryReceipt(
      id: 'h5',
      studentName: 'Ahamed Ali Mohammed',
      grade: 'Grade 2 B',
      receiptNo: 'RCP-2308',
      avatarPath: 'assets/images/student_avatar_4.png',
      amount: 62943,
      dateGroup: '22 Oct 26, Mon',
      time: '01:05 PM',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    if (selectedStudent.value == null && allStudents.isNotEmpty) {
      selectedStudent.value = allStudents.first;
    }
  }

  // Filtered Students List
  List<StudentFeeItem> get filteredStudents {
    final grade = selectedGrade.value;
    final status = selectedStatusFilter.value;
    final query = searchQuery.value.toLowerCase();

    var list = allStudents.where((s) {
      // Grade filter
      if (grade != 'All Grades' &&
          !s.grade.contains(grade.replaceAll('Grade ', ''))) {
        return false;
      }
      // Status filter
      if (status.contains('Arrears') && s.status != 'Arrear') {
        return false;
      }
      if (status.contains('Dues') && s.status != 'Due') {
        return false;
      }
      if (status.contains('Pending') && s.status != 'Pending') {
        return false;
      }
      if (status.contains('Fully Paid') && !s.isFullyPaid) {
        return false;
      }
      // Search
      if (query.isNotEmpty) {
        return s.name.toLowerCase().contains(query) ||
            s.rollNo.contains(query) ||
            s.grade.toLowerCase().contains(query);
      }
      return true;
    }).toList();
    return list;
  }

  // Filtered Fee Items in Student Detail
  List<FeeItemDetail> get filteredStudentFees {
    final filter = selectedStudentStatusFilter.value;
    final allFees = studentFeeItems.toList();
    if (filter == 'All') {
      return allFees;
    } else if (filter == 'Arrears') {
      return allFees.where((f) => f.type == 'Arrear').toList();
    } else if (filter == 'Dues') {
      return allFees.where((f) => f.type == 'Due').toList();
    } else if (filter == 'Pending') {
      return allFees.where((f) => !f.isPaid).toList();
    } else if (filter == 'Paid') {
      return allFees.where((f) => f.isPaid).toList();
    }
    return allFees;
  }

  // Selection actions for Collect Fees
  int get selectedFeeCount =>
      studentFeeItems.where((f) => !f.isPaid && f.isSelected).length;

  int get totalUnpaidFeeCount =>
      studentFeeItems.where((f) => !f.isPaid).length;

  double get selectedFeeTotalAmount {
    return studentFeeItems
        .where((f) => !f.isPaid && f.isSelected)
        .fold(0.0, (sum, item) => sum + item.amount);
  }

  void toggleFeeSelection(String id) {
    final index = studentFeeItems.indexWhere((f) => f.id == id);
    if (index != -1 && !studentFeeItems[index].isPaid) {
      studentFeeItems[index].isSelected = !studentFeeItems[index].isSelected;
      studentFeeItems.refresh();
    }
  }

  void clearSelection() {
    for (var f in studentFeeItems) {
      f.isSelected = false;
    }
    studentFeeItems.refresh();
  }

  void setFullAmount() {
    autoAmountController.text = '2943';
  }

  // Bottom Sheet Openers
  void showCollectionHistorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CollectionHistorySheet(),
    );
  }

  void showStudentCollectionHistorySheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const StudentCollectionHistorySheet(),
    );
  }

  void showCollectionSummarySheet(BuildContext context, {ReceiptDetail? detail}) {
    final receipt = detail ??
        const ReceiptDetail(
          receiptNo: 'Receipt RCP-5160',
          paymentMode: 'Via UPI',
          studentName: 'Ahamed Ali Mohammed',
          grade: 'Grade 2 B',
          rollNo: '04',
          avatarPath: 'assets/images/student_avatar_main.png',
          totalAmount: 2943,
          collectedOn: '12 September 2026, 12:34PM',
          remainingBalance: 2943,
          items: [
            ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
            ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
            ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
            ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
            ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
            ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
            ReceiptBreakdownItem(title: 'Tuition fee · Term I', amount: 9000),
          ],
        );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CollectionSummarySheet(detail: receipt),
    );
  }

  void showCollectFeesSheet(BuildContext context, StudentFeeItem student) {
    selectedStudent.value = student;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CollectFeesSheet(student: student),
    );
  }

  void submitCollection(BuildContext context) {
    Navigator.of(context).pop(); // Close collection sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const FeeCollectionSuccessDialog(),
    );
  }
}
