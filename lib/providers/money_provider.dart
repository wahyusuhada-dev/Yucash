import 'package:flutter/foundation.dart';
import '../models/transaction_model.dart';

// Provider untuk mengelola state keuangan aplikasi
class MoneyProvider extends ChangeNotifier {
  double _totalBalance = 0;
  double _income = 0;
  double _expense = 0;
  final List<String> _defaultCategories = [
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Bills',
    'Health',
    'Education',
    'Travel',
  ];
  late List<String> _customCategories;

  MoneyProvider() {
    _customCategories = [];
  }

  List<Transaction> _transactions = [];

  double get totalBalance => _totalBalance;
  double get income => _income;
  double get expense => _expense;
  List<Transaction> get transactions {
    // Urutkan berdasarkan tanggal (terbaru di depan)
    final sorted = [..._transactions];
    sorted.sort((a, b) {
      try {
        final aDate = _parseDate(a.date);
        final bDate = _parseDate(b.date);
        return bDate.compareTo(aDate); // Urutan menurun (terbaru di depan)
      } catch (e) {
        return 0;
      }
    });
    return sorted;
  }

  DateTime _parseDate(String dateStr) {
    final parts = dateStr.split('/');
    if (parts.length == 3) {
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      return DateTime(year, month, day);
    }
    return DateTime.now();
  }

  String getDisplayDate(String dateStr) {
    try {
      final txDate = _parseDate(dateStr);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));
      final txDateOnly = DateTime(txDate.year, txDate.month, txDate.day);
      
      if (txDateOnly == today) {
        return 'Hari ini';
      } else if (txDateOnly == yesterday) {
        return 'Kemarin';
      } else {
        final difference = today.difference(txDateOnly).inDays;
        if (difference > 0 && difference < 7) {
          return '$difference hari yang lalu';
        } else {
          // Show actual date for older transactions
          return dateStr;
        }
      }
    } catch (e) {
      return dateStr;
    }
  }

  void addTransaction(Transaction transaction) {
    _transactions.insert(0, transaction);
    if (transaction.isExpense) {
      _expense += double.parse(transaction.amount);
      _totalBalance -= double.parse(transaction.amount);
    } else {
      _income += double.parse(transaction.amount);
      _totalBalance += double.parse(transaction.amount);
    }
    notifyListeners();
  }

  void addBalance(double amount) {
    _totalBalance += amount;
    _income += amount;
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Added Balance',
      amount: amount.toStringAsFixed(0),
      isExpense: false,
      icon: 'add_circle',
      date: 'Today',
      category: 'Income',
    );
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  double getThisMonthBalance() {
    final now = DateTime.now();
    double monthBalance = 0;
    
    for (final transaction in _transactions) {
      try {
        // Parse date from DD/MM/YYYY format
        final parts = transaction.date.split('/');
        if (parts.length == 3) {
          final day = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final year = int.parse(parts[2]);
          final txDate = DateTime(year, month, day);
          
          // Check if transaction is in current month and year
          if (txDate.year == now.year && txDate.month == now.month) {
            final amount = double.parse(transaction.amount);
            if (transaction.isExpense) {
              monthBalance -= amount;
            } else {
              monthBalance += amount;
            }
          }
        }
      } catch (e) {
        // Skip transactions that can't be parsed
        continue;
      }
    }
    
    return monthBalance;
  }

  String formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  }

  List<String> getAllCategories() {
    return [..._defaultCategories, ..._customCategories];
  }

  void addCustomCategory(String categoryName) {
    if (categoryName.isNotEmpty && !_defaultCategories.contains(categoryName) && !_customCategories.contains(categoryName)) {
      _customCategories.add(categoryName);
      notifyListeners();
    }
  }

  void resetAll() {
    _totalBalance = 0;
    _income = 0;
    _expense = 0;
    _transactions.clear();
    notifyListeners();
  }
}
