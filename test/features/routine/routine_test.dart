import 'package:flutter_test/flutter_test.dart';
import 'package:my_campus/features/routine/data/models/routine_models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('WeeklyRoutineModel JSON parsing and day selection test', () {
    const json = {
      'semester': 'Fall 2026',
      'week': 'Week 7',
      'days': [
        {
          'dayName': 'Tue',
          'dayNumber': '29',
          'fullDate': 'Tuesday, Sep 29',
          'isToday': true,
          'lecturesCount': 1,
          'totalHours': '1.5 Hours',
          'progressPercentage': '55% Done',
          'lectures': [
            {
              'id': 'cs301_tue',
              'title': 'Computer Networks',
              'code': 'CS301',
              'hall': 'Hall B-12',
              'instructor': 'Dr. Alan Vance',
              'startTime': '10:00 AM',
              'endTime': '11:30 AM',
              'timeSpan': '10:00 AM - 11:30 AM',
              'isOngoing': true,
              'statusTag': 'HAPPENING NOW',
              'elapsedMinutes': 50,
              'totalMinutes': 90,
              'elapsedPercentage': 0.55,
              'type': 'Lecture',
            }
          ]
        }
      ]
    };

    final model = WeeklyRoutineModel.fromJson(json);
    expect(model.semester, 'Fall 2026');
    expect(model.selectedDay.dayName, 'Tue');
    expect(model.selectedDay.lectures.first.title, 'Computer Networks');
  });
}
