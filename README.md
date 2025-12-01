#  LAPORAN TUGAS UTS
## Aplikasi Katalog_Produk_Elektronik
---
##  IDENTITAS MAHASISWA

**Nama** :Rizki Abd. Rahman
**NIM**  :230102118
**Kelas**:IF23B
**Mata Kuliah**: Pemrograman Perangkat Bergerak
**Dosen Pengampu**: 1. Fajar Winata S.Kom., M.T.
                    2. Rizky Kharisma N. E. P. S.Tr.Kom., M.T.
**Link GitHub**: 
**Email**: ikirahman152@gmail.com

---

## DESKRIPSI APLIKASI

**Katalog Produk Elektronik** adalah aplikasi mobile berbasis Flutter untuk menampilkan katalog produk elektronik dengan fitur pencarian, filter kategori, keranjang belanja, dan checkout.

Aplikasi ini dibuat untuk memenuhi **Tugas Besar UTS Pemrograman Perangkat Bergerak** dengan spesifikasi:

**Implementasi 5 jenis layout** (Dasar, Multi-Child, Kompleks, Scrollable, Responsif)  
**3 halaman utama** (Home Page, Detail Page, Grid Page) sesuai requirement  
**2 custom widget** yang reusable (ProductCard, CustomButton)  
**ThemeData** untuk konsistensi UI  
**Struktur folder** rapi dan terorganisir  
**Responsive design** dengan MediaQuery dan LayoutBuilder  
**tambahan** (Cart, Search, Filter, Validation)  

Aplikasi ini mendemonstrasikan pemahaman mendalam tentang Flutter layout system, widget composition, dan best practices dalam pengembangan aplikasi mobile yang responsif dan user-friendly.

## TEKNOLOGI YANG DIGUNAKAN

| Teknologi | Versi | Kegunaan |
|-----------|-------|----------|
| Flutter SDK | >=3.0.0 | Framework utama |
| Dart | >=3.0.0 | Bahasa pemrograman |
| Material Design 3 | Latest | UI Components |
| Unsplash API | - | Source gambar produk |

---

##  STRUKTUR FOLDER PROJECT

catalog_produk_elektronik/
├── lib/
│   ├── main.dart                 # Entry point aplikasi
│   ├── models/
│   │   ├── product.dart          # Model data produk
│   │   └── cart_item.dart        # Model item keranjang
│   ├── screens/
│   │   ├── home_page.dart        # Halaman utama (HOME PAGE - REQUIREMENT)
│   │   ├── detail_page.dart      # Halaman detail (DETAIL PAGE - REQUIREMENT)
│   │   ├── grid_page.dart        # Halaman grid katalog (GRID PAGE - REQUIREMENT)
│   │   ├── cart_page.dart        # Halaman keranjang (FITUR BONUS)
│   │   ├── checkout_page.dart    # Halaman checkout (FITUR BONUS)
│   │   └── promo_page.dart       # Halaman promo (FITUR BONUS)
│   ├── widgets/
│   │   ├── product_card.dart     # Custom widget card produk (CUSTOM WIDGET 1)
│   │   └── custom_button.dart    # Custom widget button (CUSTOM WIDGET 2)
│   ├── services/
│   │   └── cart_service.dart     # Service management keranjang (Singleton Pattern)
│   └── theme/
│       └── app_theme.dart        # Konfigurasi tema aplikasi (ThemeData)
├── pubspec.yaml                   # Dependencies
└── README.md                      # Dokumentasi


### Penjelasan Struktur:
- **models/**: Berisi class model untuk data (Product, CartItem)
- **screens/**: Berisi semua halaman aplikasi (3 wajib + 3 bonus)
- **widgets/**: Berisi 2 custom widget yang reusable
- **services/**: Berisi business logic (CartService dengan Singleton pattern)
- **theme/**: Berisi konfigurasi tema dan color scheme

---

## IMPLEMENTASI 5 JENIS LAYOUT FLUTTER

### 1. Layout Dasar (Single Child)

**Widget yang Digunakan:** `Container`, `Center`, `Padding`, `Align`

**Lokasi Implementasi:**
- **HomePage**: Container dengan gradient di header
- **ProductCard**: Padding untuk info produk
- **SearchDelegate**: Center untuk empty state
- **CheckoutPage**: Container untuk ringkasan pesanan


---

### 2. Layout Multi-Child (Row/Column)

**Widget yang Digunakan:** `Row`, `Column`, `Expanded`, `Spacer`

**Lokasi Implementasi:**
- **HomePage**: Row untuk 4 kategori dengan Expanded
- **ProductCard**: Row untuk rating dan stock
- **CheckoutPage**: Column untuk form layout
- **DetailPage**: Row untuk price section




**Fungsi:** Menampilkan 4 kategori secara horizontal dengan lebar yang sama menggunakan `Expanded`, sehingga responsive di berbagai ukuran layar.

---

### 3. Layout Kompleks

**Widget yang Digunakan:** `Stack`, `Positioned`

**Lokasi Implementasi:**
- **HomePage**: Stack di promo banner dengan Positioned button
- **ProductCard**: Stack untuk gambar dengan badge kategori dan stock
- **DetailPage**: Stack di hero image dengan Positioned badge


**Fungsi:** Menumpuk gambar produk dengan 2 badge (kategori dan stock) yang ditempatkan pada posisi absolut menggunakan `Positioned`.

---

### 4. Layout Scrollable

**Widget yang Digunakan:** `ListView`, `GridView`, `SingleChildScrollView`

**Lokasi Implementasi:**

**a. ListView Vertical (HomePage)**

**Fungsi:** Memungkinkan scroll vertikal untuk seluruh konten HomePage,

**b. ListView Horizontal (Featured Products)**

**Fungsi:** Menampilkan 4 produk unggulan yang bisa di-scroll horizontal.

**c. GridView (GridPage)**

**Fungsi:** Menampilkan 8 produk dalam bentuk grid 2 kolom (phone) atau 3-4 kolom (tablet).

**d. SingleChildScrollView (DetailPage)**

**Fungsi:** Memungkinkan scroll vertikal untuk konten detail produk yang panjang.

---

### 5. Layout Responsif/Adaptif

**Widget yang Digunakan:** `MediaQuery`, `LayoutBuilder`, `Flexible`

**Lokasi Implementasi:**

**a. MediaQuery untuk Deteksi Ukuran Layar**

**Fungsi:** Menyesuaikan font size, padding, dan spacing berdasarkan ukuran layar.

**b. LayoutBuilder untuk Responsive Columns**

**Fungsi:** 
- Phone (< 600px): 2 kolom
- Tablet (600-900px): 3 kolom
- Desktop (> 900px): 4 kolom

---

##  SPESIFIKASI HALAMAN

### 1. Home Page (`home_page.dart`)

**Requirement:**
- Header dengan nama aplikasi "Elektronik Shop" dan icon store  
- Komponen Row (kategori 4 kolom) dan Column (layout utama)  
- ombol navigasi ke halaman lain (Grid Page)

**Fitur:**
- Search bar dengan SearchDelegate
- 4 Kategori dalam Row dengan Expanded
- Banner promo dengan Stack + Positioned
- Featured products (horizontal scroll)
- Navigation button ke Grid Page

**Layout yang Digunakan:**
- Container, Padding (Layout dasar)
- Row, Column, Expanded (Multi-child)
- Stack, Positioned (Kompleks)
- ListView (Scrollable)
- MediaQuery (Responsif)

---

### 2. Detail Page (`detail_page.dart`)

**Requirement:**
- Stack untuk hero image dengan badge overlay  
- SingleChildScrollView untuk konten scrollable

**Fitur:**
- Hero image dengan Stack dan Positioned badge
- Product information lengkap
- Rating dan stock
- Price section dengan gradient
- Deskripsi dan spesifikasi
- Quantity selector (+/-)
- Related products horizontal scroll
- Add to cart & Buy now buttons

**Layout yang Digunakan:**
- Stack, Positioned (Kompleks)
- SingleChildScrollView (Scrollable)
- Column, Row (Multi-child)
- Container, Padding (Dasar)
- MediaQuery (Responsif)

---

### 3. Grid Page (`grid_page.dart`)

**Requirement:**
- GridView menampilkan minimal 6 item (app memiliki 8 produk)  
- Setiap item memiliki nama dan gambar

**Fitur:**
- GridView dengan 10 produk:
  1. iPhone 15 Pro
  2. MacBook Pro M3
  3. iPad Air 5
  4. AirPods Pro 2
  5. Apple Watch Ultra 2
  6. Samsung Galaxy S24
  7. Sony WH-1000XM5
  8. Dell XPS 15
  9. iphone 17 pro
- Filter kategori horizontal
- Sort options (Nama, Harga, Rating)
- Search functionality
- Bottom sheet filter

**Layout yang Digunakan:**
- GridView (Scrollable)
- LayoutBuilder (Responsif)
- Row untuk filter (Multi-child)
- Container, Padding (Dasar)
- Stack, Positioned (ProductCard)

---

## CUSTOM WIDGETS

### 1. ProductCard Widget (`lib/widgets/product_card.dart`)

**Fungsi:** Menampilkan card produk dengan gambar, badge kategori, badge stock, rating, dan harga.

**Layout yang Digunakan:**
- `Stack` - Menumpuk gambar dengan badges
- `Positioned` - Menempatkan badge pada posisi tertentu
- `Column` - Menyusun info produk vertikal
- `Row` - Menampilkan rating dan stock horizontal
- `Expanded` - Membuat gambar mengisi space yang tersedia

**Reusable di:**
- HomePage (Featured Products)
- GridPage (10 produk)

---

### 2. CustomButton Widget (`lib/widgets/custom_button.dart`)

**Fungsi:** Button custom dengan gradient background, icon, dan animasi scale saat ditekan.

**Layout yang Digunakan:**
- `Container` - Wrapper dengan gradient decoration
- `Row` - Menyusun icon dan text horizontal
- `InkWell` - Efek ripple saat ditekan
- `ScaleTransition` - Animasi scale

**Fitur:**
- Gradient background
- Support icon
- Scale animation saat tap
- Customizable color
- Box shadow

**Reusable di:**
- HomePage (Navigation buttons)
- DetailPage (Bottom bar buttons)

---

## TEMA APLIKASI

**File:** `lib/theme/app_theme.dart`

### **Color Palette:**
- Primary Color: Blue `#2196F3`
- Secondary Color: Orange `#FF9800`
- Accent Color: Green `#4CAF50`
- Background: Light Grey `#F5F5F5`
- Text Primary: Dark Grey `#212121`
- Text Secondary: Medium Grey `#757575`

### **Typography:**
- Headline Large: 32px bold
- Headline Medium: 24px bold
- Body Large: 16px
- Body Medium: 14px

### **Component Themes:**
- **AppBar**: Primary color dengan elevation 0
- **Card**: Rounded 16px dengan elevation 4
- **Button**: Rounded 12px dengan gradient background

---

##  PEMENUHAN REQUIREMENT TUGAS

| Requirement |  Keterangan |
|-------------|--------|------------|
| **1. LAYOUT (25%)** |  |
| Layout Dasar |  Container, Center, Padding, Align |
| Layout Multi-Child |  Row, Column, Expanded, Spacer |
| Layout Kompleks |  Stack, Positioned |
| Layout Scrollable |  ListView, GridView, SingleChildScrollView |
| Layout Responsif |  MediaQuery, LayoutBuilder, Flexible |
| **2. SPESIFIKASI HALAMAN** |  |
| Home Page - Header + icon |  | "Elektronik Shop" + Icons.store |
| Home Page - Row & Column  | Kategori (Row), Layout utama (Column) |
| Home Page - Navigation button |  Tombol ke Grid Page |
| Detail Page - Stack overlay |  Hero image + Positioned badge |
| Detail Page - Scrollable |  SingleChildScrollView |
| Grid Page - GridView 6+ item  | 8 produk dengan ProductCard |
| Grid Page - Nama + gambar  | Setiap card lengkap |
| **3. KETENTUAN TEKNIS** |  |
| Flutter stable terbaru  | Compatible dengan Flutter 3.x+ |
| Struktur folder rapi | screens/widgets/models/services/theme |
| 2 custom widget | ProductCard, CustomButton |
| ThemeData |  AppTheme dengan color scheme |
| pubspec.yaml |  Lengkap dengan dependencies |
| **4. RESPONSIVE** |  |
| MediaQuery/LayoutBuilder |  Semua halaman responsive |
| No overflow | Clip behavior + Expanded |


---

## FITUR TAMBAHAN 

Fitur-fitur di bawah ini  dalam requirement tugas, tetapi ditambahkan untuk meningkatkan fungsionalitas dan user experience:

### 1. Shopping Cart System
- Add to cart dari Detail Page
- Update quantity (+/-)
- Delete item dari cart
- Real-time badge counter di AppBar
- Total price calculation
- Cart Service dengan Singleton Pattern

### 2. Search Functionality
- Search bar di HomePage
- Real-time filtering by nama, kategori, deskripsi
- Empty state UI
- Direct navigation ke Detail Page dari hasil

### 3. Filter & Sort
- Filter: 6 kategori (Semua, Smartphone, Laptop, Tablet, Audio, Wearable)
- Sort: Nama (A-Z), Harga Terendah, Harga Tertinggi, Rating Tertinggi
- Bottom sheet filter UI

### 4. Checkout dengan Form Validation
- Form 5 field: Nama, Telepon, Alamat, Kota, Kode Pos
- Validasi required dan format
- Loading indicator
- Success dialog
- Auto clear cart setelah checkout

### 5. Promo Page
- Banner promo dengan gradient
- List produk promo
- Navigation ke detail produk

##  KONTAK

**Nama:** Rizki Abd. Rahman  
**NIM:** 230102118  
**Kelas:** IF23B  
**Email:** ikirahman152@gmail.com 
**GitHub:** IkiRahman