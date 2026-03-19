import 'package:flutter_test/flutter_test.dart';
import 'package:manager_portal/features/staff_management/presentation/utils/staff_utils.dart';

void main() {
  group('StaffUtils.formatDate', () {
    test('returns "Never" when date is null', () {
      expect(StaffUtils.formatDate(null), 'Never');
    });

    test('returns "Just now" for dates within 60 seconds', () {
      final now = DateTime.now();
      expect(StaffUtils.formatDate(now), 'Just now');
      expect(
        StaffUtils.formatDate(now.subtract(const Duration(seconds: 59))),
        'Just now',
      );
    });

    test('returns "Just now" for future dates (clock drift)', () {
      final future = DateTime.now().add(const Duration(minutes: 5));
      expect(StaffUtils.formatDate(future), 'Just now');
    });

    test('returns minutes ago for less than 1 hour', () {
      final date = DateTime.now().subtract(const Duration(minutes: 45));
      expect(StaffUtils.formatDate(date), '45m ago');
    });

    test('returns hours ago for less than 24 hours', () {
      final date = DateTime.now().subtract(const Duration(hours: 3));
      expect(StaffUtils.formatDate(date), '3h ago');
    });

    test('returns days ago for less than 7 days', () {
      final date = DateTime.now().subtract(const Duration(days: 4));
      expect(StaffUtils.formatDate(date), '4d ago');
    });

    test('returns formatted date for older than 7 days', () {
      final date = DateTime(2023, 10, 15);
      expect(StaffUtils.formatDate(date), '15 Oct 2023');
    });
  });
}
