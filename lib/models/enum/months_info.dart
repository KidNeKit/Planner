enum MonthsInfo {
  january(1, 'January', 31),
  february(2, 'February', 28),
  march(3, 'March', 31),
  april(4, 'April', 30),
  may(5, 'May', 31),
  june(6, 'June', 30),
  july(7, 'July', 31),
  august(8, 'August', 31),
  september(9, 'September', 30),
  october(10, 'October', 31),
  november(11, 'November', 30),
  december(12, 'December', 31);

  final int order;
  final String fullName;
  final int days;

  const MonthsInfo(this.order, this.fullName, this.days);

  int getDays(int year) {
    if (this == february) {
      return 29;
    }
    return days;
  }

  static MonthsInfo getMonthByOrder(int order) {
    return MonthsInfo.values.firstWhere((element) => element.order == order);
  }
}
