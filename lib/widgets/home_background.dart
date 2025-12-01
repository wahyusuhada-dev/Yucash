import 'package:flutter/material.dart';

// Widget latar belakang dekoratif untuk halaman utama
class HomeBackground extends StatelessWidget {
  const HomeBackground({super.key});
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = c.maxHeight;

        return Stack(
          children: [
            // LAYER 1: Background full putih
            Container(
              width: w,
              height: h,
              color: Colors.white,
            ),

            // LAYER 2: Hijau di bagian atas
            Container(
              width: w,
              height: h * 0.4, // tinggi bisa lu atur
              color: const Color(0xFF00CC99), // caribbean green
            ),

            // LAYER 3: Lengkungan putih turun ke bawah
            Positioned(
              top: h * 0.3, // posisinya turun sedikit dari hijau
              left: 0,
              right: 0,
              child: Container(
                width: w,
                height: h * 0.75, // sisanya
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(60), // besar lengkung bebas
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
