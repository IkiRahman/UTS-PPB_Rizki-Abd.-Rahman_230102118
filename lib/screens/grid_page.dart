import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';
import '../theme/app_theme.dart';
import 'detail_page.dart';

// HALAMAN 3: GRID PAGE
// Layout yang digunakan:
// 1. Layout scrollable: GridView
// 2. Layout responsif: MediaQuery, LayoutBuilder
// 3. Layout multi-child: Column, Row
// 4. Custom Widget: ProductCard
class GridPage extends StatefulWidget {
  final String? initialCategory;
  
  const GridPage({super.key, this.initialCategory});

  @override
  State<GridPage> createState() => _GridPageState();
}

class _GridPageState extends State<GridPage> {
  late String selectedCategory;
  String sortBy = 'name';
  List<Product> products = Product.getDummyProducts();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialCategory ?? 'Semua';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;
    
    // Menggunakan LayoutBuilder untuk menentukan jumlah kolom
    int crossAxisCount = isTablet ? 3 : 2;
    if (screenWidth > 900) crossAxisCount = 4;

    // Filter dan sort products
    List<Product> filteredProducts = _getFilteredAndSortedProducts();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Produk'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(products),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              setState(() => sortBy = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name',
                child: Text('Urutkan: Nama'),
              ),
              const PopupMenuItem(
                value: 'price_low',
                child: Text('Urutkan: Harga Terendah'),
              ),
              const PopupMenuItem(
                value: 'price_high',
                child: Text('Urutkan: Harga Tertinggi'),
              ),
              const PopupMenuItem(
                value: 'rating',
                child: Text('Urutkan: Rating'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Kategori menggunakan Row dan ScrollView
          _buildCategoryFilter(isTablet),
          
          // Info jumlah produk
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isTablet ? 24 : 16,
              vertical: 12,
            ),
            color: AppTheme.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Menampilkan ${filteredProducts.length} produk',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet ? 16 : 14,
                  ),
                ),
                Text(
                  _getSortText(),
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: isTablet ? 14 : 12,
                  ),
                ),
              ],
            ),
          ),

          // GridView produk
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: EdgeInsets.all(isTablet ? 24 : 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: 0.76,
                    crossAxisSpacing: isTablet ? 20 : 16,
                    mainAxisSpacing: isTablet ? 20 : 16,
                  ),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetailPage(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showFilterBottomSheet(context, isTablet);
        },
        icon: const Icon(Icons.filter_list),
        label: const Text('Filter'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }

  // Category Filter menggunakan horizontal ListView
  Widget _buildCategoryFilter(bool isTablet) {
    final categories = ['Semua', 'Smartphone', 'Laptop', 'Tablet', 'Audio', 'Wearable'];

    return Container(
      height: isTablet ? 70 : 60,
      padding: EdgeInsets.symmetric(vertical: isTablet ? 12 : 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return GestureDetector(
            onTap: () {
              setState(() => selectedCategory = category);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 24 : 20,
                vertical: isTablet ? 12 : 10,
              ),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(25),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.textPrimary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    fontSize: isTablet ? 16 : 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Filter dan Sort logic
  List<Product> _getFilteredAndSortedProducts() {
    List<Product> filtered = selectedCategory == 'Semua'
        ? List.from(products)
        : products.where((p) => p.category == selectedCategory).toList();

    // Sort
    switch (sortBy) {
      case 'name':
        filtered.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'price_low':
        filtered.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        filtered.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }

    return filtered;
  }

  String _getSortText() {
    switch (sortBy) {
      case 'name':
        return 'A-Z';
      case 'price_low':
        return 'Termurah';
      case 'price_high':
        return 'Termahal';
      case 'rating':
        return 'Rating Tertinggi';
      default:
        return '';
    }
  }

  // Bottom Sheet Filter
  void _showFilterBottomSheet(BuildContext context, bool isTablet) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  left: isTablet ? 32 : 24,
                  right: isTablet ? 32 : 24,
                  top: isTablet ? 32 : 24,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Filter & Urutkan',
                          style: TextStyle(
                            fontSize: isTablet ? 24 : 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ['Semua', 'Smartphone', 'Laptop', 'Tablet', 'Audio', 'Wearable']
                          .map((cat) => ChoiceChip(
                                label: Text(cat),
                                selected: selectedCategory == cat,
                                onSelected: (selected) {
                                  setModalState(() {
                                    selectedCategory = cat;
                                  });
                                  setState(() {
                                    selectedCategory = cat;
                                  });
                                },
                                selectedColor: AppTheme.primaryColor,
                                labelStyle: TextStyle(
                                  color: selectedCategory == cat
                                      ? Colors.white
                                      : AppTheme.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Urutkan',
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    RadioListTile<String>(
                      title: const Text('Nama (A-Z)'),
                      value: 'name',
                      groupValue: sortBy,
                      onChanged: (value) {
                        setModalState(() {
                          sortBy = value!;
                        });
                        setState(() {
                          sortBy = value!;
                        });
                      },
                      activeColor: AppTheme.primaryColor,
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      title: const Text('Harga Terendah'),
                      value: 'price_low',
                      groupValue: sortBy,
                      onChanged: (value) {
                        setModalState(() {
                          sortBy = value!;
                        });
                        setState(() {
                          sortBy = value!;
                        });
                      },
                      activeColor: AppTheme.primaryColor,
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      title: const Text('Harga Tertinggi'),
                      value: 'price_high',
                      groupValue: sortBy,
                      onChanged: (value) {
                        setModalState(() {
                          sortBy = value!;
                        });
                        setState(() {
                          sortBy = value!;
                        });
                      },
                      activeColor: AppTheme.primaryColor,
                      contentPadding: EdgeInsets.zero,
                    ),
                    RadioListTile<String>(
                      title: const Text('Rating Tertinggi'),
                      value: 'rating',
                      groupValue: sortBy,
                      onChanged: (value) {
                        setModalState(() {
                          sortBy = value!;
                        });
                        setState(() {
                          sortBy = value!;
                        });
                      },
                      activeColor: AppTheme.primaryColor,
                      contentPadding: EdgeInsets.zero,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Terapkan Filter',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// Search Delegate untuk fitur search
class ProductSearchDelegate extends SearchDelegate<Product?> {
  final List<Product> products;

  ProductSearchDelegate(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
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
    final results = products
        .where((p) =>
            p.name.toLowerCase().contains(query.toLowerCase()) ||
            p.category.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Produk tidak ditemukan',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${product.category} • ${product.formattedPrice}',
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
        );
      },
    );
  }
}