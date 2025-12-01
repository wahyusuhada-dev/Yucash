// Model untuk merepresentasikan sebuah transaksi keuangan
class Transaction {
  final String id;
  final String title;
  final String amount;
  final bool isExpense;
  final String icon;
  final String date;
  final String category;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.isExpense,
    required this.icon,
    required this.date,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'] as String,
      title: json['title'] as String,
      amount: json['amount'] as String,
      isExpense: json['isExpense'] as bool,
      icon: json['icon'] as String,
      date: json['date'] as String,
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'isExpense': isExpense,
      'icon': icon,
      'date': date,
      'category': category,
    };
  }
}
