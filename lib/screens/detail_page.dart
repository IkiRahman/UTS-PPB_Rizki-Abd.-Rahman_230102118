import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_button.dart';
import '../services/cart_service.dart';
import 'checkout_page.dart';

// HALAMAN 2: DETAIL PAGE
// Layout yang digunakan:
// 1. Layout kompleks: Stack, Positioned
// 2. Layout scrollable: SingleChildScrollView
// 3. Layout dasar: Container, Padding, Align
// 4. Layout multi-child: Column, Row
// 5. Layout responsif: MediaQuery
class DetailPage extends StatefulWidget {
  final Product product;

  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int quantity = 1;
  bool isFavorite = false;
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      // AppBar transparan untuk Stack
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : AppTheme.textPrimary,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      isFavorite
                          ? 'Ditambahkan ke favorit'
                          : 'Dihapus dari favorit',
                    ),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image dengan Stack dan Positioned
            _buildHeroImage(isTablet),

            // Product Info
            Padding(
              padding: EdgeInsets.all(isTablet ? 24 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name & Category
                  _buildProductHeader(isTablet),
                  const SizedBox(height: 16),

                  // Rating & Stock
                  _buildRatingAndStock(isTablet),
                  const SizedBox(height: 24),

                  // Price Section
                  _buildPriceSection(isTablet),
                  const SizedBox(height: 24),

                  // Description
                  _buildDescription(isTablet),
                  const SizedBox(height: 24),

                  // Specifications dengan Container dan Padding
                  _buildSpecifications(isTablet),
                  const SizedBox(height: 24),

                  // Quantity Selector
                  _buildQuantitySelector(isTablet),
                  const SizedBox(height: 24),

                  // Related Products Preview
                  _buildRelatedProducts(isTablet),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom Navigation dengan Custom Button
      bottomNavigationBar: _buildBottomBar(isTablet),
    );
  }

  // Hero Image dengan Stack dan Positioned
  Widget _buildHeroImage(bool isTablet) {
    return Stack(
      children: [
        // Background gradient
        Container(
          height: isTablet ? 450 : 350,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.primaryColor.withOpacity(0.1),
                Colors.white,
              ],
            ),
          ),
        ),
        // Product Image
        Center(
          child: Container(
            height: isTablet ? 450 : 350,
            padding: EdgeInsets.all(isTablet ? 48 : 32),
            child: Hero(
              tag: 'product-${widget.product.id}',
              child: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        // Badge menggunakan Positioned
        Positioned(
          top: isTablet ? 120 : 100,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.secondaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              widget.product.category,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductHeader(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.product.name,
          style: TextStyle(
            fontSize: isTablet ? 32 : 28,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.accentColor.withOpacity(0.3)),
          ),
          child: Text(
            widget.product.category,
            style: TextStyle(
              color: AppTheme.accentColor,
              fontWeight: FontWeight.w600,
              fontSize: isTablet ? 16 : 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingAndStock(bool isTablet) {
    return Row(
      children: [
        // Rating
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                widget.product.rating.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 16 : 14,
                ),
              ),
              Text(
                ' (4.2k reviews)',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: isTablet ? 14 : 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // Stock
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: widget.product.stock > 20
                ? Colors.green.withOpacity(0.1)
                : Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.inventory_2,
                color: widget.product.stock > 20 ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: 4),
              Text(
                'Stock: ${widget.product.stock}',
                style: TextStyle(
                  color: widget.product.stock > 20 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: isTablet ? 16 : 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceSection(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            AppTheme.accentColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Harga',
                style: TextStyle(
                  color: AppTheme.textSecondary,
                  fontSize: isTablet ? 16 : 14,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.product.formattedPrice,
                style: TextStyle(
                  fontSize: isTablet ? 32 : 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'HEMAT 20%',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: isTablet ? 16 : 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deskripsi Produk',
          style: TextStyle(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          widget.product.description,
          style: TextStyle(
            fontSize: isTablet ? 16 : 14,
            color: AppTheme.textSecondary,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildSpecifications(bool isTablet) {
    final specs = [
      {'icon': Icons.memory, 'title': 'Processor', 'value': 'High Performance'},
      {'icon': Icons.battery_full, 'title': 'Battery', 'value': 'Long Lasting'},
      {'icon': Icons.camera_alt, 'title': 'Camera', 'value': 'Pro Quality'},
      {'icon': Icons.shield, 'title': 'Warranty', 'value': '2 Years'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spesifikasi',
          style: TextStyle(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...specs.map((spec) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      spec['icon'] as IconData,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          spec['title'] as String,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: isTablet ? 16 : 14,
                          ),
                        ),
                        Text(
                          spec['value'] as String,
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: isTablet ? 14 : 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  Widget _buildQuantitySelector(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jumlah',
          style: TextStyle(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildQuantityButton(
              Icons.remove,
              () {
                if (quantity > 1) {
                  setState(() => quantity--);
                }
              },
              isTablet,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.symmetric(
                horizontal: isTablet ? 32 : 24,
                vertical: isTablet ? 16 : 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.primaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  fontSize: isTablet ? 24 : 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            _buildQuantityButton(
              Icons.add,
              () {
                if (quantity < widget.product.stock) {
                  setState(() => quantity++);
                }
              },
              isTablet,
            ),
            const Spacer(),
            Text(
              'Total: ${_formatPrice(widget.product.price * quantity)}',
              style: TextStyle(
                fontSize: isTablet ? 20 : 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuantityButton(
    IconData icon,
    VoidCallback onPressed,
    bool isTablet,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
        iconSize: isTablet ? 28 : 24,
      ),
    );
  }

  Widget _buildRelatedProducts(bool isTablet) {
    final relatedProducts = Product.getDummyProducts()
        .where((p) => p.id != widget.product.id && p.category == widget.product.category)
        .take(3)
        .toList();

    if (relatedProducts.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Produk Serupa',
          style: TextStyle(
            fontSize: isTablet ? 22 : 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: isTablet ? 130 : 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: relatedProducts.length,
            itemBuilder: (context, index) {
              final product = relatedProducts[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailPage(product: product),
                    ),
                  );
                },
                child: Container(
                  width: isTablet ? 280 : 240,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.imageUrl,
                          width: isTablet ? 90 : 80,
                          height: isTablet ? 90 : 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 14 : 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product.formattedPrice,
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: isTablet ? 14 : 12,
                              ),
                            ),
                          ],
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

  Widget _buildBottomBar(bool isTablet) {
    return Container(
      padding: EdgeInsets.all(isTablet ? 24 : 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'Tambah ke Keranjang',
                icon: Icons.shopping_cart,
                backgroundColor: AppTheme.accentColor,
                onPressed: () {
                  setState(() {
                    _cartService.addItem(widget.product, quantity);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '${widget.product.name} (${quantity}x) ditambahkan ke keranjang',
                      ),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                      action: SnackBarAction(
                        label: 'OK',
                        onPressed: () {},
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: 'Beli Sekarang',
                icon: Icons.payment,
                onPressed: () {
                  // Tambahkan produk ke cart
                  setState(() {
                    _cartService.addItem(widget.product, quantity);
                  });
                  
                  // Langsung ke halaman checkout dengan form
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CheckoutPage(),
                    ),
                  ).then((_) {
                    // Refresh state setelah kembali dari checkout
                    if (mounted) {
                      setState(() {});
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatPrice(double price) {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }
}