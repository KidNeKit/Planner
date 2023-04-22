enum DaysOfWeek {
  monday(1, 'Monday'),
  tuesday(2, 'Tuesday'),
  wednesday(3, 'Wednesday'),
  thursday(4, 'Thursday'),
  friday(5, 'Friday'),
  saturday(6, 'Saturday'),
  sunday(7, 'Sunday');

  final int order;
  final String fullName;

  const DaysOfWeek(this.order, this.fullName);

  static DaysOfWeek getDayOfWeekByOrder(int order) {
    return values.firstWhere((element) => element.order == order);
  }
}
