enum Timeframe { today, yesterday, last7Days, last30Days, custom }

extension TimeframeExtension on Timeframe {
  String get label {
    switch (this) {
      case Timeframe.today:
        return 'Today';
      case Timeframe.yesterday:
        return 'Yesterday';
      case Timeframe.last7Days:
        return 'Last 7 Days';
      case Timeframe.last30Days:
        return 'Last 30 Days';
      case Timeframe.custom:
        return 'Custom Range';
    }
  }
}
