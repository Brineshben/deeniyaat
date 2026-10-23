class TimetablePeriodModel {
  final String id;
  final String time;
  final String grade;
  final String subject;
  final String bgImage;
  final bool isAfternoon;

  const TimetablePeriodModel({
    required this.id,
    required this.time,
    required this.grade,
    required this.subject,
    required this.bgImage,
    this.isAfternoon = false,
  });
}
