import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/custom_button.dart';
import '../theme/app_theme.dart';
import '../services/cart_service.dart';
import 'grid_page.dart';
import 'detail_page.dart';
import 'cart_page.dart';
import 'promo_page.dart';

// HALAMAN 1: HOME PAGE
// Layout yang digunakan:
// 1. Layout dasar: Container, Center, Padding, Align
// 2. Layout multi-child: Row, Column, Expanded, Spacer
// 3. Layout scrollable: ListView
// 4. Layout responsif: MediaQuery, LayoutBuilder
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CartService _cartService = CartService();
  final List<Product> products = Product.getDummyProducts();

  @override
  Widget build(BuildContext context) {
    // Menggunakan MediaQuery untuk responsif
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.store,
              color: Colors.white,
              size: isTablet ? 28 : 24,
            ),
            const SizedBox(width: 8),
            Text(
              'Elektronik Shop',
              style: TextStyle(
                fontSize: isTablet ? 24 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  ).then((_) => setState(() {}));
                },
              ),
              if (_cartService.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${_cartService.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Menggunakan LayoutBuilder untuk layout responsif
          return ListView(
            padding: EdgeInsets.all(isTablet ? 24 : 16),
            children: [
              // Header Section dengan Container dan Padding
              _buildHeaderSection(context, isTablet),
              const SizedBox(height: 24),

              // Kategori Section dengan Row dan Column
              _buildCategorySection(context, isTablet),
              const SizedBox(height: 24),

              // Promo Banner dengan Stack
              _buildPromoBanner(context, isTablet),
              const SizedBox(height: 24),

              // Featured Products dengan Column dan Row
              _buildFeaturedProducts(context, products, isTablet),
              const SizedBox(height: 24),

              // Navigation Buttons
              _buildNavigationButtons(context, isTablet),
            ],
          );
        },
      ),
    );
  }

  // Header Section - Menggunakan Container, Padding, Align
  Widget _buildHeaderSection(BuildContext context, bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 32 : 24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang! 👋',
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 28 : 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Temukan produk elektronik terbaik untuk Anda',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: isTablet ? 18 : 16,
            ),
          ),
          const SizedBox(height: 16),
          // Search bar 
          GestureDetector(
            onTap: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(products),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.search, color: AppTheme.textSecondary),
                  const SizedBox(width: 8),
                  Text(
                    'Cari produk...',
                    style: TextStyle(
                      fontSize: isTablet ? 16 : 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Category Section - Menggunakan Row, Column, Expanded
  Widget _buildCategorySection(BuildContext context, bool isTablet) {
    final categories = [
      {'icon': Icons.phone_android, 'name': 'Smartphone', 'color': Colors.blue},
      {'icon': Icons.laptop, 'name': 'Laptop', 'color': Colors.green},
      {'icon': Icons.tablet, 'name': 'Tablet', 'color': Colors.orange},
      {'icon': Icons.headphones, 'name': 'Audio', 'color': Colors.purple},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kategori',
          style: TextStyle(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: categories.map((category) {
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _buildCategoryCard(
                  context,
                  category['icon'] as IconData,
                  category['name'] as String,
                  category['color'] as Color,
                  isTablet,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    IconData icon,
    String name,
    Color color,
    bool isTablet,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GridPage(initialCategory: name == 'Semua' ? null : name),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(isTablet ? 20 : 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: isTablet ? 36 : 32,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: TextStyle(
                fontSize: isTablet ? 14 : 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Promo Banner - Menggunakan Stack dan Positioned
  Widget _buildPromoBanner(BuildContext context, bool isTablet) {
    return Stack(
      children: [
        Container(
          height: isTablet ? 200 : 150,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.secondaryColor, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          left: isTablet ? 32 : 24,
          top: isTablet ? 32 : 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PROMO SPESIAL! 🎉',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 26 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Diskon hingga 50%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isTablet ? 18 : 16,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: isTablet ? 24 : 16,
          bottom: isTablet ? 24 : 16,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PromoPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppTheme.secondaryColor,
            ),
            child: const Text('Lihat Promo'),
          ),
        ),
      ],
    );
  }

  // Featured Products - Menggunakan Column dan horizontal ListView
  Widget _buildFeaturedProducts(
    BuildContext context,
    List<Product> products,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Produk Unggulan',
              style: TextStyle(
                fontSize: isTablet ? 22 : 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: isTablet ? 180 : 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.take(4).length,
            itemBuilder: (context, index) {
              final product = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(product: product),
                    ),
                  );
                },
                child: Container(
                  width: isTablet ? 280 : 240,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(16),
                        ),
                        child: Image.network(
                          product.imageUrl,
                          width: isTablet ? 120 : 100,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: isTablet ? 120 : 100,
                              color: Colors.grey.shade300,
                              child: const Icon(Icons.image, size: 40),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 16 : 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                product.category,
                                style: TextStyle(
                                  color: AppTheme.textSecondary,
                                  fontSize: isTablet ? 13 : 12,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                product.formattedPrice,
                                style: TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: isTablet ? 16 : 14,
                                ),
                              ),
                            ],
                          ),
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
    );
  }

  // Navigation Buttons - Menggunakan Custom Widget dan Column
  Widget _buildNavigationButtons(BuildContext context, bool isTablet) {
    return Column(
      children: [
        CustomButton(
          text: 'Lihat Semua Produk',
          icon: Icons.grid_view,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GridPage()),
            );
          },
          width: double.infinity,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// Search Delegate untuk fitur search di Home
class ProductSearchDelegate extends SearchDelegate<Product?> {
  final List<Product> products;

  ProductSearchDelegate(this.products);

  @override
  String get searchFieldLabel => 'Cari produk...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white70),
        border: InputBorder.none,
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Cari produk elektronik',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Ketik nama produk atau kategori',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    final results = products
        .where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.category.toLowerCase().contains(query.toLowerCase()) ||
            p.description.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Produk tidak ditemukan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Coba kata kunci lain',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image, size: 30),
                  );
                },
              ),
            ),
            title: Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  product.category,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.formattedPrice,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              close(context, product);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailPage(product: product),
                ),
              );
            },
          ),
        );
      },
    );
  }
}