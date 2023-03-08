class Transaction {
  final String type;
  final String day;
  final DateTime date;
  final String memo;
  final int? id;
  final int amount;
  final int categoryindex;
  Transaction(
      {required this.type,
      required this.day,
      required this.date,
      required this.memo,
      this.id,
      required this.amount,
      required this.categoryindex});
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json['type'],
      day: json['day'],
      date: json['month'],
      memo: json['memo'],
      id: json['id'],
      amount: json['amount'],
      categoryindex: json['categoryindex'],
    );
  }
}
