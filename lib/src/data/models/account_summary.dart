class AccountSummaryModel {
  final int dailyTotal;
  final int weeklyTotal;
  final int monthlyTotal;

  AccountSummaryModel({
    required this.dailyTotal,
    required this.weeklyTotal,
    required this.monthlyTotal,
  });

  factory AccountSummaryModel.fromJson(Map<String, dynamic> json) {
    return AccountSummaryModel(
      dailyTotal: json['daily_total'],
      weeklyTotal: json['weekly_total'],
      monthlyTotal: json['monthly_total'],
    );
  }
}
