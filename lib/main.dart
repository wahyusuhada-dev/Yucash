import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'screens/homescreen.dart';
import 'screens/detail_page.dart';
import 'screens/grid_page.dart';
import 'providers/money_provider.dart';

void main() {
  runApp(const MoneyApp());
}

class MoneyApp extends StatelessWidget {
  const MoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider untuk manajemen state aplikasi
        ChangeNotifierProvider(create: (_) => MoneyProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'yucash - Money Manager',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            // Warna utama aplikasi: teal/hijau kebiruan
            seedColor: const Color(0xFF00CC99),
          ),
        ),
        home: const SplashScreen(),
        routes: {
          '/home': (context) => const HomeScreen(),
          '/detail': (context) => const DetailPage(),
          '/grid': (context) => const GridPage(),
        },
      ),
    );
  }
}
