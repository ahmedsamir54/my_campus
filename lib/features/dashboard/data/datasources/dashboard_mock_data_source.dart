import '../models/dashboard_models.dart';

abstract class DashboardDataSource {
  Future<DashboardDataModel> getDashboardData();
}

class DashboardMockDataSource implements DashboardDataSource {
  @override
  Future<DashboardDataModel> getDashboardData() async {
    // Simulating realistic campus network latency
    await Future.delayed(const Duration(milliseconds: 350));

    return const DashboardDataModel(
      studentName: 'Student',
      studentStatus: '• Omi',
      semester: 'Semester 6',
      weather: 'Sunny 28°C',
      notificationCount: 3,
      nextClass: NextClassModel(
        courseTitle: 'Data Structures',
        room: 'Lab 302',
        instructor: 'Prof. Alan Vance',
        startTime: 'Starts 10:30 AM',
        countdown: 'In 15m',
      ),
      quickActions: [
        QuickActionItemModel(
          id: 'notices',
          label: 'Notices',
          iconCode: 'article',
          route: '/notices',
        ),
        QuickActionItemModel(
          id: 'classes',
          label: 'Classes',
          iconCode: 'laptop',
          route: '/routine',
        ),
        QuickActionItemModel(
          id: 'attendance',
          label: 'Attendance',
          iconCode: 'calendar_check',
          badge: '94%',
          route: '/attendance',
        ),
        QuickActionItemModel(
          id: 'results',
          label: 'Results',
          iconCode: 'bar_chart',
          route: '/academics',
        ),
        QuickActionItemModel(
          id: 'assignments',
          label: 'Assignments',
          iconCode: 'assignment_turned_in',
          route: '/assignments',
        ),
        QuickActionItemModel(
          id: 'events',
          label: 'Events',
          iconCode: 'event',
          route: '/events',
        ),
        QuickActionItemModel(
          id: 'profile',
          label: 'Profile',
          iconCode: 'person',
          route: '/profile',
        ),
        QuickActionItemModel(
          id: 'more',
          label: 'More',
          iconCode: 'more_horiz',
          route: '/services',
        ),
      ],
      featuredEvent: FeaturedEventModel(
        id: 'hackathon_2026',
        categoryTag: 'FEATURED CAMPUS EVENT',
        deadlineBadge: 'Registration Closes in 2 Days',
        title: 'Annual AI & Robotics Hackathon 2026',
        description:
            'Join 500+ innovators • \$10,000 in Prizes & Mentorship • Innovation Lab Hall',
        audience: 'Open to all faculties',
        buttonLabel: 'Register Free ->',
      ),
    );
  }
}
