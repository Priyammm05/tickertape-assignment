class CustomDateUtils {
  static String formatDateToCustomString(String utcTimestamp) {
    final dateTime = DateTime.parse(utcTimestamp);
    return "${_addOrdinalSuffix(dateTime.day)} ${_getMonth(dateTime.month)}";
  }

  static String _getMonth(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  static String _addOrdinalSuffix(int day) {
    if (day >= 11 && day <= 13) {
      return "${day}th";
    }

    switch (day % 10) {
      case 1:
        return "${day}st";
      case 2:
        return "${day}nd";
      case 3:
        return "${day}rd";
      default:
        return "${day}th";
    }
  }
}
