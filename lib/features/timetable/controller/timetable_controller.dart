import 'package:get/get.dart';
import '../model/timetable_model.dart';

class TimetableController extends GetxController {
  final List<String> weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  final RxInt selectedDayIndex = 1.obs; // Tue selected as in Figma 200:16178

  final RxList<TimetablePeriodModel> morningPeriods = <TimetablePeriodModel>[
    const TimetablePeriodModel(
      id: '1',
      time: '10:00 am–10:45 am',
      grade: 'Grade 2B',
      subject: 'Qur’an & Tajweed',
      bgImage: 'assets/images/timetable_card_bg_1.png',
      isAfternoon: false,
    ),
    const TimetablePeriodModel(
      id: '2',
      time: '10:50 am–11:35 am',
      grade: 'Grade 2B',
      subject: 'Islamic Studies & Hadith',
      bgImage: 'assets/images/timetable_card_bg_2.png',
      isAfternoon: false,
    ),
    const TimetablePeriodModel(
      id: '3',
      time: '11:40 am–12:25 pm',
      grade: 'Grade 2B',
      subject: 'Arabic Language',
      bgImage: 'assets/images/timetable_card_bg_3.png',
      isAfternoon: false,
    ),
  ].obs;

  final RxList<TimetablePeriodModel> afternoonPeriods = <TimetablePeriodModel>[
    const TimetablePeriodModel(
      id: '4',
      time: '01:30 pm–02:15 pm',
      grade: 'Grade 2B',
      subject: 'Duas & Supplications',
      bgImage: 'assets/images/timetable_card_bg_1.png',
      isAfternoon: true,
    ),
    const TimetablePeriodModel(
      id: '5',
      time: '02:20 pm–03:05 pm',
      grade: 'Grade 2B',
      subject: 'Qur’an Recitation',
      bgImage: 'assets/images/timetable_card_bg_2.png',
      isAfternoon: true,
    ),
    const TimetablePeriodModel(
      id: '6',
      time: '03:10 pm–03:55 pm',
      grade: 'Grade 2B',
      subject: 'Islamic History',
      bgImage: 'assets/images/timetable_card_bg_3.png',
      isAfternoon: true,
    ),
  ].obs;

  void selectDay(int index) {
    selectedDayIndex.value = index;
  }
}
