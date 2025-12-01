// Utility untuk format dan parse mata uang Rupiah
class CurrencyFormatter {
  /// Format input dengan pemisah ribuan otomatis saat user mengetik
  static String formatInput(String value) {
    if (value.isEmpty) return '';
    
    // Remove any non-digit characters
    String digits = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return '';
    
    // Add dots every 3 digits from right
    return digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  /// Parse string berformat kembali menjadi double
  static double parseFormatted(String formatted) {
    String digits = formatted.replaceAll(RegExp(r'[^\d]'), '');
    return double.parse(digits.isEmpty ? '0' : digits);
  }

  /// Format double ke tampilan mata uang Rp
  static String formatCurrency(double amount) {
    return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => '.')}';
  }
}
