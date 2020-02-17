import 'package:intl/intl.dart';

class DateUtils {
  static String ymdHmsStr(DateTime dateTime) {
    if (dateTime != null) {
      return ymdHmsDf().format(dateTime);
    }

    return null;
  }

  static DateTime ymdHmsDate(String dateTime) {
    if (dateTime != null) {
      return ymdHmsDf().parse(dateTime);
    }

    return null;
  }

  static String ymdStr(DateTime dateTime) {
    if (dateTime != null) {
      return ymdDf().format(dateTime);
    }

    return null;
  }

  static String hmsStr(DateTime dateTime) {
    if (dateTime != null) {
      return hmsDf().format(dateTime);
    }

    return null;
  }

  static bool sameYmd(DateTime selDate, DateTime date) {
    if (selDate != null && date != null) {
      return ymdDf().format(selDate) == ymdDf().format(date);
    }

    return false;
  }

  static DateFormat ymdDf() {
    return new DateFormat('yyyy-MM-dd');
  }

  static DateFormat hmsDf() {
    return new DateFormat('HH:mm:ss');
  }

  static DateFormat ymdHmsDf() {
    return new DateFormat('yyyy-MM-dd HH:mm:ss');
  }
}
