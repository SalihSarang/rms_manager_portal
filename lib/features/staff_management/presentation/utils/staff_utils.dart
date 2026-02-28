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
    if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
}
