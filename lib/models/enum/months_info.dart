enum MonthsInfo {
  january(1, 'Jan', 31),
  february(2, 'Feb', 28),
  march(3, 'Mar', 31),
  april(4, 'Apr', 30),
  may(5, 'May', 31),
  june(6, 'Jun', 30),
  july(7, 'Jul', 31),
  august(8, 'Aug', 31),
  september(9, 'Sep', 30),
  october(10, 'Oct', 31),
  november(11, 'Nov', 30),
  december(12, 'Dec', 31);

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
