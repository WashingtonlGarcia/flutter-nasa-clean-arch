class DateToStringConvert {
  DateToStringConvert._();

  static String convert({required DateTime date}) => date.toString().split(' ').first;
}
