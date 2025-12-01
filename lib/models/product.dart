class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String description;
  final String imageUrl;
  final double rating;
  final int stock;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.stock,
  });

  // Data dummy produk
  static List<Product> getDummyProducts() {
    return [
      Product(
        id: '1',
        name: 'iPhone 15 Pro',
        category: 'Smartphone',
        price: 15999000,
        description: 'iPhone terbaru dengan chipset A17 Pro, kamera 48MP, dan layar ProMotion 120Hz. Design titanium premium dengan performa terbaik di kelasnya.',
        imageUrl: 'https://images.unsplash.com/photo-1678685888221-cda773a3dcdb?w=400&q=80',
        rating: 4.8,
        stock: 25,
      ),
      Product(
        id: '2',
        name: 'MacBook Pro M3',
        category: 'Laptop',
        price: 29999000,
        description: 'Laptop profesional dengan chip M3 yang powerful, layar Liquid Retina XDR 14 inch, RAM 16GB, dan SSD 512GB. Cocok untuk developer dan content creator.',
        imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
        rating: 4.9,
        stock: 15,
      ),
      Product(
        id: '3',
        name: 'iPad Air 5',
        category: 'Tablet',
        price: 8999000,
        description: 'iPad dengan chip M1, layar 10.9 inch Liquid Retina, mendukung Apple Pencil Gen 2. Perfect untuk produktivitas dan entertainment.',
        imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
        rating: 4.7,
        stock: 30,
      ),
      Product(
        id: '4',
        name: 'AirPods Pro 2',
        category: 'Audio',
        price: 3499000,
        description: 'Earbuds premium dengan Active Noise Cancellation, Spatial Audio, dan battery life hingga 30 jam dengan charging case.',
        imageUrl: 'https://images.unsplash.com/photo-1606841837239-c5a1a4a07af7?w=400',
        rating: 4.8,
        stock: 50,
      ),
      Product(
        id: '5',
        name: 'Apple Watch Ultra 2',
        category: 'Wearable',
        price: 12999000,
        description: 'Smartwatch dengan design rugged titanium, layar Always-On Retina 49mm, GPS presisi, dan tahan air hingga 100 meter.',
        imageUrl: 'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400',
        rating: 4.9,
        stock: 20,
      ),
      Product(
        id: '6',
        name: 'Samsung Galaxy S24',
        category: 'Smartphone',
        price: 12999000,
        description: 'Flagship Samsung dengan AI features, kamera 200MP, layar Dynamic AMOLED 2X, dan battery 5000mAh dengan fast charging.',
        imageUrl: 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=400',
        rating: 4.7,
        stock: 35,
      ),
      Product(
        id: '7',
        name: 'Sony WH-1000XM5',
        category: 'Audio',
        price: 4999000,
        description: 'Headphone premium dengan industri-leading noise cancellation, Hi-Res Audio, dan battery life 30 jam.',
        imageUrl: 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=400',
        rating: 4.8,
        stock: 40,
      ),
      Product(
        id: '8',
        name: 'Dell XPS 15',
        category: 'Laptop',
        price: 24999000,
        description: 'Laptop premium dengan Intel Core i7 Gen 13, RTX 4060, layar OLED 15.6 inch 4K, RAM 32GB, dan SSD 1TB.',
        imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=400',
        rating: 4.6,
        stock: 12,
      ),
       Product(
        id: '9',
        name: 'Apple Watch Series 10',
        category: 'Wearable',
        price: 8999000,
        description:
            'Smartwatch premium dengan desain flat-edge, sensor kesehatan terbaru, dan daya tahan baterai lebih baik.',
        imageUrl:
            'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=400',
        rating: 4.8,
        stock: 40,
      ), 
      Product(
        id: '10',
        name: 'iPhone 17 Pro',
        category: 'Smartphone',
        price: 18999000,
        description: 'iPhone 17 Pro terbaru dengan chipset A19, kamera triple 50MP, layar ProMotion 120Hz, dan design Cosmic Orange premium.',
        imageUrl: 'https://images.unsplash.com/photo-1758348844305-c8351d0d6b45?w=400&q=400',
        rating: 4.9,
        stock: 20,
      ),   
    ];
  }

  // Format harga ke Rupiah
  String get formattedPrice {
    return 'Rp ${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }
}