# Yucash - Money Management App

Aplikasi Flutter sederhana untuk mengelola keuangan pribadi dengan fitur tracking transaksi, kategorisasi pengeluaran, dan visualisasi data keuangan yang menarik.

## 📱 Tentang Aplikasi

**Yucash** adalah aplikasi manajemen keuangan yang dirancang untuk memudahkan pengguna dalam melacak pendapatan dan pengeluaran harian. Aplikasi ini menerapkan prinsip-prinsip UI/UX modern dengan Material Design 3 dan menyediakan pengalaman pengguna yang responsif di berbagai ukuran layar.

### 🎯 Fitur Utama

- 💰 **Manajemen Saldo**: Tambahkan saldo/pendapatan langsung ke aplikasi
- 📝 **Tracking Transaksi**: Catat setiap pengeluaran dengan detail lengkap
- 🏷️ **Kategorisasi**: 8 kategori pengeluaran yang sudah tersedia (Food, Transport, Shopping, dll)
- 📊 **Riwayat Transaksi**: Lihat semua transaksi dengan sorting otomatis (terbaru di depan)
- 🎨 **Tanggal Dinamis**: Tampilan tanggal yang user-friendly ("Hari ini", "Kemarin", "X hari yang lalu")
- 📱 **Responsive Design**: Tampilan yang menyesuaikan dengan ukuran layar (Mobile, Tablet, Desktop)
- 🔄 **Reset Data**: Fitur untuk mereset semua transaksi dan saldo

---

## ✨ Spesifikasi Teknis

### Layout yang Diimplementasikan (5+ Jenis)

1. **Layout Dasar (Single Child)**
   - Container, Padding, Align, SizedBox
   - Digunakan di seluruh aplikasi untuk styling dan spacing

2. **Layout Multi-Child (Row/Column)**
   - Kombinasi Row untuk statistik horizontal (Total Balance + This Month)
   - Column untuk stacking vertikal di setiap halaman
   - Expanded dan Spacer untuk kontrol ukuran

3. **Layout Kompleks (Stack + Positioned)**
   - **Detail Page**: Stack dengan background hijau + Positioned white card di bawah
   - **Category Detail Page**: Stack overlay untuk balance card kategori
   - Menciptakan visual yang modern dan depth

4. **Layout Scrollable**
   - **SingleChildScrollView**: Untuk keseluruhan halaman agar scrollable
   - **ListView**: Menampilkan daftar transaksi dengan efisien
   - **GridView**: Menampilkan 8 kategori dalam grid responsif

5. **Layout Responsive/Adaptif**
   - **LayoutBuilder**: Di GridPage untuk menghitung kolom dinamis (2/3/4 kolom)
   - **MediaQuery**: Untuk menyesuaikan ukuran elemen berdasarkan layar
   - **Flexible**: Untuk flexible sizing di berbagai perangkat

### Halaman Aplikasi

#### 1️⃣ **Splash Screen** (Loading)
- Logo aplikasi (120x120)
- Judul "Yucash" dengan subtitle
- Auto-navigate ke home setelah 3 detik
- Fallback ke wallet icon jika logo.png tidak tersedia

#### 2️⃣ **Home Page** (Halaman Utama)
- **Header**: Logo + Judul "Yucash" + Subtitle
- **Statistik Cepat**: 
  - Total Balance (seluruh saldo)
  - This Month (kalkulasi dinamis transaksi bulan ini)
- **Tombol Aksi**:
  - Add Balance (tambah saldo/pendapatan)
  - Add Expense (catat pengeluaran)
- **Tombol Navigasi**:
  - View Details (ke halaman detail transaksi)
  - Browse Categories (ke halaman grid kategori)
- **Riwayat Transaksi**: Menampilkan 3 transaksi terbaru dengan format compact

#### 3️⃣ **Detail Page** (Halaman Riwayat)
- **Stack Header**: Background hijau dengan overlay white card
- **Balance Overview**:
  - Total Balance (besar)
  - Income vs Expense (breakdown)
- **Transaction List**: Daftar lengkap semua transaksi
  - Sorting otomatis (terbaru di depan)
  - Smart date display ("Hari ini", "Kemarin", "X hari yang lalu")
  - Kategori dan jumlah transaksi terlihat
- **Reset Button**: Untuk mereset semua data

#### 4️⃣ **Grid Page** (Kategori)
- **Category Grid**: 8 kategori dalam grid responsif
  - Food (Merah)
  - Transport (Cyan)
  - Shopping (Gold)
  - Entertainment (Sky Blue)
  - Bills (Purple)
  - Health (Pink)
  - Education (Green)
  - Travel (Blue)
- Setiap kategori clickable → membuka Category Detail Page

#### 5️⃣ **Category Detail Page** (Detail Kategori)
- **Stack Header**: Background dengan warna kategori
- **Category Info**: 
  - Total pengeluaran kategori
  - Jumlah transaksi
- **Filtered Transaction List**: Hanya transaksi dari kategori tersebut

---

## 🛠️ Teknologi & Dependencies

### Framework & SDK
- **Flutter**: Stable Channel (v3.10.1+)
- **Dart**: ^3.10.1
- **Material Design 3**: Modern UI framework

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  provider: ^6.0.0  # State Management
```

### Development Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

---

## 📦 Struktur Project

```
lib/
├── main.dart                          # Entry point aplikasi
├── screens/
│   ├── splash_screen.dart             # Splash/Loading screen
│   ├── homescreen.dart                # Halaman utama
│   ├── detail_page.dart               # Halaman riwayat transaksi
│   └── grid_page.dart                 # Halaman grid kategori
├── widgets/
│   ├── app_header.dart                # Custom widget header dengan logo
│   └── home_background.dart           # Custom widget background dekoratif
├── providers/
│   └── money_provider.dart            # State management dengan Provider
├── models/
│   └── transaction_model.dart         # Model data transaksi
└── utils/
    └── currency_formatter.dart        # Utility untuk format mata uang Rp

assets/
└── logo.png                           # Logo aplikasi (optional)
```

---

## 🚀 Cara Menjalankan

### Prerequisites
- Flutter SDK installed ([Download](https://flutter.dev/docs/get-started/install))
- Android Emulator / iOS Simulator atau Real Device
- Visual Studio Code / Android Studio / Xcode

### Setup & Run

1. **Clone Repository**
```bash
git clone https://github.com/uwahyusuhada-dev/Yucash.git
cd yucash
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Format Kode**
```bash
dart format .
```

4. **Run Application**
```bash
# Semua device yang tersedia
flutter run

# Device spesifik
flutter run -d <device_id>
```

5. **Build APK (Android)**
```bash
flutter build apk --release
```

6. **Build iOS**
```bash
flutter build ios --release
```

---

## 💡 Panduan Penggunaan

### 1. Pertama Kali Buka Aplikasi
- Aplikasi menampilkan splash screen selama 3 detik
- Otomatis navigate ke home page

### 2. Menambah Saldo/Pendapatan
- Klik tombol **"Add Balance"**
- Input jumlah uang (format otomatis dengan pemisah ribuan)
- Saldo total langsung terupdate

### 3. Mencatat Pengeluaran
- Klik tombol **"Add Expense"**
- Isi nama transaksi
- Input jumlah uang
- Pilih tanggal (default: hari ini)
- Pilih kategori
- Klik "Add"

### 4. Melihat Riwayat Lengkap
- Klik tombol **"View Details"**
- Lihat breakdown Income vs Expense
- Scroll untuk melihat semua transaksi
- Klik "Reset" (dengan konfirmasi) untuk hapus semua data

### 5. Jelajahi Kategori
- Klik tombol **"Browse Categories"**
- Pilih kategori yang ingin dilihat
- Lihat total pengeluaran per kategori
- Lihat semua transaksi dalam kategori tersebut

---

## 🎨 Tema & Warna

### Warna Utama
- **Primary Color**: #00CC99 (Teal/Hijau Kebiruan)
- **Success**: Green (#4CAF50)
- **Error**: Red (#F44336)
- **Background**: White (#FFFFFF)

### Kategori Pengeluaran
| Kategori | Warna |
|----------|-------|
| Food | #FF6B6B (Merah) |
| Transport | #4ECDC4 (Cyan) |
| Shopping | #FFD700 (Gold) |
| Entertainment | #7FD8FA (Sky Blue) |
| Bills | #B88EFF (Purple) |
| Health | #FF85A2 (Pink) |
| Education | #6BCB77 (Green) |
| Travel | #4D96FF (Blue) |

---

## 🔧 Custom Widgets

### 1. **AppHeader**
```dart
AppHeader(
  title: 'Yucash',
  subtitle: 'Money Management App',
)
```
Widget reusable untuk menampilkan header dengan logo dan teks.

### 2. **HomeBackground**
```dart
HomeBackground()
```
Widget dekoratif untuk background halaman utama dengan curved design.

### 3. **_ActionButton** (Private)
Widget tombol aksi dengan icon dan label.

### 4. **_NavButton** (Private)
Widget tombol navigasi dengan styling khusus.

### 5. **_CategoryCard** (Private)
Widget kategori dengan icon dan warna.

---

## 📊 State Management

### Provider Pattern
Aplikasi menggunakan **Provider ^6.0.0** untuk state management:

```dart
ChangeNotifierProvider(
  create: (_) => MoneyProvider(),
  child: MaterialApp(...)
)
```

### MoneyProvider Class
Mengelola:
- `totalBalance`: Total saldo
- `income`: Total pendapatan
- `expense`: Total pengeluaran
- `_transactions`: List transaksi
- Methods: `addBalance()`, `addTransaction()`, `resetAll()`

---

## 🔄 Fitur Khusus

### 1. **Currency Formatting**
- Input otomatis menambahkan pemisah ribuan (titik)
- Display format: "Rp X.XXX.XXX"
- Utility: `CurrencyFormatter` class

### 2. **Smart Date Display**
- "Hari ini" - untuk transaksi hari ini
- "Kemarin" - untuk transaksi kemarin
- "X hari yang lalu" - untuk transaksi < 7 hari
- Tanggal normal - untuk transaksi lebih lama

### 3. **Dynamic "This Month" Calculation**
- Kalkulasi otomatis transaksi bulan berjalan
- Update real-time saat transaksi baru ditambahkan
- Tampil dengan warna green (+) atau red (-)

### 4. **Responsive Layout**
- GridView otomatis menghitung kolom (2/3/4) berdasarkan lebar layar
- Tidak ada overflow pada layar kecil
- Optimal spacing untuk semua ukuran perangkat

---

## 📝 Lisensi

Project ini dibuat sebagai tugas UTS Pemrograman Perangkat Bergerak (PPB).

---

## 👨‍💻 Author

**Nama Mahasiswa**: Wahyu Suhada  
**NIM**: 220102086
**Program Studi**: Teknik Informatika  
**Universitas**: Universitas Muhammadiyah Bandung

---

## 📞 Kontak & Support

Untuk pertanyaan atau feedback, silakan hubungi atau buka issue di repository ini.

---

## 🙏 Acknowledgments

- Flutter Team untuk framework yang amazing
- Material Design untuk design guidelines
- Provider package untuk state management
- Semua dokumentasi dan tutorial yang membantu

---

**Last Updated**: December 1, 2025  
**Status**: ✅ Complete & Ready for Production
