class DateTimeUtils {
  static DateTime convertDateTimeToUTC({required DateTime dateTime}) {
    final now = dateTime;
    final utc = now.toUtc();
    return utc;
  }
  static DateTime convertUTCToDateTime({required DateTime dateTime}) {
    final now = dateTime;
    final utc = now.toLocal();
    return utc;
  }
}