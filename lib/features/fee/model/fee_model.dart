class StudentFeeItem {
  final String id;
  final String name;
  final String grade;
  final String rollNo;
  final String avatarPath;
  final double amountDue;
  final bool isFullyPaid;
  final int arrearsCount;
  final int duesCount;
  final String status; // 'Arrear', 'Due', 'Pending', 'Fully Paid'

  const StudentFeeItem({
    required this.id,
    required this.name,
    required this.grade,
    required this.rollNo,
    required this.avatarPath,
    required this.amountDue,
    required this.isFullyPaid,
    this.arrearsCount = 0,
    this.duesCount = 0,
    required this.status,
  });

  String get formattedAmount => '₹ ${amountDue.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';
}

class FeeItemDetail {
  final String id;
  final String title;
  final String term; // 'Term I', 'Term II'
  final String type; // 'Arrear', 'Paid', 'Due', 'Pending'
  final String dateText;
  final double amount;
  final bool isPaid;
  bool isSelected;

  FeeItemDetail({
    required this.id,
    required this.title,
    required this.term,
    required this.type,
    required this.dateText,
    required this.amount,
    required this.isPaid,
    this.isSelected = false,
  });

  String get formattedAmount => '₹ ${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';
}

class CollectionHistoryReceipt {
  final String id;
  final String studentName;
  final String grade;
  final String receiptNo;
  final String avatarPath;
  final double amount;
  final String dateGroup; // 'Today', '22 Oct 26, Mon'
  final String time;

  const CollectionHistoryReceipt({
    required this.id,
    required this.studentName,
    required this.grade,
    required this.receiptNo,
    required this.avatarPath,
    required this.amount,
    required this.dateGroup,
    required this.time,
  });

  String get formattedAmount => '₹ ${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';
}

class ReceiptBreakdownItem {
  final String title;
  final double amount;

  const ReceiptBreakdownItem({
    required this.title,
    required this.amount,
  });

  String get formattedAmount => '₹${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';
}

class ReceiptDetail {
  final String receiptNo;
  final String paymentMode;
  final String studentName;
  final String grade;
  final String rollNo;
  final String avatarPath;
  final double totalAmount;
  final String collectedOn;
  final double remainingBalance;
  final List<ReceiptBreakdownItem> items;

  const ReceiptDetail({
    required this.receiptNo,
    required this.paymentMode,
    required this.studentName,
    required this.grade,
    required this.rollNo,
    required this.avatarPath,
    required this.totalAmount,
    required this.collectedOn,
    required this.remainingBalance,
    required this.items,
  });

  String get formattedTotal => '₹ ${totalAmount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';

  String get formattedRemaining => '₹ ${remainingBalance.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},',
      )}';
}
