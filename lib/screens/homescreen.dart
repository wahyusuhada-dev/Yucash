import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/home_background.dart';
import '../widgets/app_header.dart';
import '../providers/money_provider.dart';
import '../models/transaction_model.dart';
import '../utils/currency_formatter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const HomeBackground(),
          Consumer<MoneyProvider>(
            builder: (context, moneyProvider, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    const AppHeader(
                      title: 'Yucash',
                      subtitle: 'Money Management App',
                    ),
                    const SizedBox(height: 40),
                    // Statistik cepat menggunakan Row + Column
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Total Balance',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    moneyProvider.formatCurrency(moneyProvider.totalBalance),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF00CC99),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 6,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'This Month',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Builder(
                                    builder: (context) {
                                      final thisMonthBalance = moneyProvider.getThisMonthBalance();
                                      final isPositive = thisMonthBalance >= 0;
                                      final displayValue = moneyProvider.formatCurrency(thisMonthBalance.abs());
                                      return Text(
                                        '${isPositive ? '+' : '-'}$displayValue',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: isPositive ? Colors.green : Colors.red,
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Tombol aksi (Tambah Saldo dan Tambah Pengeluaran)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _ActionButton(
                                  label: 'Add Balance',
                                  icon: Icons.add,
                                  color: Colors.green,
                                  onPressed: () => _showAddBalanceDialog(context, moneyProvider),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _ActionButton(
                                  label: 'Add Expense',
                                  icon: Icons.remove,
                                  color: Colors.red,
                                  onPressed: () => _showAddTransactionDialog(context, moneyProvider, true),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _NavButton(
                            label: 'View Details',
                            icon: Icons.info,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/detail');
                            },
                          ),
                          const SizedBox(height: 12),
                          _NavButton(
                            label: 'Browse Categories',
                            icon: Icons.grid_view,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/grid');
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Riwayat transaksi terbaru
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Riwayat Transaksi',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (moneyProvider.transactions.isEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.center,
                              child: Text(
                                'Belum ada transaksi',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[600],
                                ),
                              ),
                            )
                          else
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxHeight: 250),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: moneyProvider.transactions.length > 3 ? 3 : moneyProvider.transactions.length,
                                itemBuilder: (context, index) {
                                  final tx = moneyProvider.transactions[index];
                                  final isExpense = tx.isExpense;
                                  final amount = double.parse(tx.amount);
                                  
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: isExpense
                                            ? Colors.red.withValues(alpha: 0.05)
                                            : Colors.green.withValues(alpha: 0.05),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: isExpense
                                              ? Colors.red.withValues(alpha: 0.2)
                                              : Colors.green.withValues(alpha: 0.2),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: isExpense
                                                  ? Colors.red.withValues(alpha: 0.2)
                                                  : Colors.green.withValues(alpha: 0.2),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              isExpense ? Icons.remove : Icons.add,
                                              color: isExpense ? Colors.red : Colors.green,
                                              size: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  tx.title,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 13,
                                                    color: Colors.black87,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  tx.category,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '${isExpense ? '-' : '+'}${moneyProvider.formatCurrency(amount)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: isExpense ? Colors.red : Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showAddBalanceDialog(BuildContext context, MoneyProvider provider) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Add Balance'),
              content: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final formatted = CurrencyFormatter.formatInput(value);
                  if (formatted != value) {
                    controller.value = TextEditingValue(
                      text: formatted,
                      selection: TextSelection.collapsed(offset: formatted.length),
                    );
                  }
                },
                decoration: const InputDecoration(
                  hintText: 'Enter amount',
                  prefixText: 'Rp ',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      final amount = CurrencyFormatter.parseFormatted(controller.text);
                      provider.addBalance(amount);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Balance added successfully!')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showAddTransactionDialog(BuildContext context, MoneyProvider provider, bool isExpense) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedCategory = 'Food';
    DateTime selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            final allCategories = provider.getAllCategories();
            return AlertDialog(
              title: Text(isExpense ? 'Add Expense' : 'Add Income'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Transaction name',
                        labelText: 'Name',
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        final formatted = CurrencyFormatter.formatInput(value);
                        if (formatted != value) {
                          amountController.value = TextEditingValue(
                            text: formatted,
                            selection: TextSelection.collapsed(offset: formatted.length),
                          );
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter amount',
                        labelText: 'Amount',
                        prefixText: 'Rp ',
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Pemilih Tanggal
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null) {
                            setState(() {
                              selectedDate = picked;
                            });
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tanggal',
                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                  ),
                                const SizedBox(height: 4),
                                Text(
                                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Icon(Icons.calendar_today, color: Color(0xFF00CC99)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButton<String>(
                      value: allCategories.contains(selectedCategory) ? selectedCategory : allCategories.first,
                      isExpanded: true,
                      items: allCategories
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value ?? 'Food';
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty && amountController.text.isNotEmpty) {
                      final amount = CurrencyFormatter.parseFormatted(amountController.text);
                      final transaction = Transaction(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: titleController.text,
                        amount: amount.toStringAsFixed(0),
                        isExpense: isExpense,
                        icon: 'attach_money',
                        date: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        category: selectedCategory,
                      );
                      provider.addTransaction(transaction);
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${isExpense ? 'Expense' : 'Income'} added successfully!')),
                      );
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: Colors.white, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _NavButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFF00CC99),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00CC99).withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
