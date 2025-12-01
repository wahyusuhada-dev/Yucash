import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/money_provider.dart';

class GridPage extends StatelessWidget {
  const GridPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Categories'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Jumlah kolom yang responsive berdasarkan lebar layar
            int crossAxisCount = 2;
            if (constraints.maxWidth > 600) {
              crossAxisCount = 3;
            }
            if (constraints.maxWidth > 900) {
              crossAxisCount = 4;
            }

            final categories = [
              ('Food', Icons.restaurant, const Color(0xFFFF6B6B)),
              ('Transport', Icons.directions_car, const Color(0xFF4ECDC4)),
              ('Shopping', Icons.shopping_bag, const Color(0xFFFFD700)),
              ('Entertainment', Icons.movie, const Color(0xFF7FD8FA)),
              ('Bills', Icons.receipt, const Color(0xFFB88EFF)),
              ('Health', Icons.local_hospital, const Color(0xFFFF85A2)),
              ('Education', Icons.school, const Color(0xFF6BCB77)),
              ('Travel', Icons.flight, const Color(0xFF4D96FF)),
            ];

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.1,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        // Widget kartu kategori yang dapat diklik
                        return _CategoryCard(
                          name: category.$1,
                          icon: category.$2,
                          color: category.$3,
                          onTap: () {
                            // Navigasi ke halaman detail kategori
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CategoryDetailPage(
                                  categoryName: category.$1,
                                  categoryIcon: category.$2,
                                  categoryColor: category.$3,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryDetailPage extends StatelessWidget {
  final String categoryName;
  final IconData categoryIcon;
  final Color categoryColor;

  const CategoryDetailPage({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<MoneyProvider>(
        builder: (context, moneyProvider, child) {
          // Filter transaksi berdasarkan kategori
          final categoryTransactions = moneyProvider.transactions
              .where((tx) => tx.category == categoryName)
              .toList();

          return SingleChildScrollView(
            child: Column(
              children: [
                // Stack untuk overlay header dengan kartu informasi kategori
                Stack(
                  children: [
                    Container(
                      height: 250,
                      color: categoryColor,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      right: 20,
                      // Kartu informasi kategori yang overlap di atas
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: categoryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    categoryIcon,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Total Pengeluaran',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        moneyProvider.formatCurrency(
                                          categoryTransactions.fold(0.0, (sum, tx) {
                                            if (tx.isExpense) {
                                              return sum + double.parse(tx.amount);
                                            }
                                            return sum;
                                          }),
                                        ),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: categoryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              '${categoryTransactions.length} transaction${categoryTransactions.length != 1 ? 's' : ''}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Transaction list
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaksi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (categoryTransactions.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.inbox,
                                  size: 64,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(height: 16),
                                const Text(
                                  'Belum ada transaksi dalam kategori ini',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...List.generate(
                          categoryTransactions.length,
                          (index) {
                            final tx = categoryTransactions[index];
                            final isExpense = tx.isExpense;
                            final amount = double.parse(tx.amount);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.all(14),
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
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isExpense
                                            ? Colors.red.withValues(alpha: 0.2)
                                            : Colors.green.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        isExpense ? Icons.remove : Icons.add,
                                        color: isExpense ? Colors.red : Colors.green,
                                        size: 18,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tx.title,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            moneyProvider.getDisplayDate(tx.date),
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      '${isExpense ? '-' : '+'}${moneyProvider.formatCurrency(amount)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: isExpense ? Colors.red : Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }
}
