class StaffUtils {
  static String getInitials(String name) {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) return "NA";

    List<String> names = trimmedName
        .split(" ")
        .where((s) => s.isNotEmpty)
        .toList();

    String initials = "";

    if (names.isNotEmpty) {
      initials += names[0][0];
      if (names.length > 1) {
        initials += names[names.length - 1][0];
      }
    }

    return initials.toUpperCase();
  }

  static String formatDate(DateTime? date) {
    if (date == null) return 'Never';
    final now = DateTime.now();
    final difference = now.difference(date);

    // Handle future dates due to clock drift
    if (difference.isNegative || difference.inSeconds < 60) {
      return "Just now";
    }

    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    }

    if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    }

    if (difference.inDays < 7) {
      return "${difference.inDays}d ago";
    }

    // For older than a week, show the actual date
    return "${date.day.toString().padLeft(2, '0')} ${_getMonthName(date.month)} ${date.year}";
  }

  static String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
