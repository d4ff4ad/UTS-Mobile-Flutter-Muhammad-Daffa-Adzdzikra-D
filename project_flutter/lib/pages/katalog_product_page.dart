import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String shopName;
  final double rating;
  final String city;
  final int soldCount;
  final double? originalPrice;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.shopName,
    required this.rating,
    required this.city,
    required this.soldCount,
    this.originalPrice,
  });
}

class KatalogProduk extends StatefulWidget {
  const KatalogProduk({super.key});

  @override
  State<KatalogProduk> createState() => _KatalogProdukState();
}

class _KatalogProdukState extends State<KatalogProduk> {
  final Set<String> _favoriteIds = {};

  final List<Product> products = [
    Product(
      id: '1',
      name: 'Sushi Mentai',
      description: 'Paket sushi mentai lezat dengan saus spesial, salmon segar, dan nori pilihan. Cocok untuk dinikmati bersama teman atau sendirian.',
      price: 59000,
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500&q=80',
      shopName: 'Sushi Hub',
      rating: 4.8,
      city: 'Jakarta Selatan',
      soldCount: 1200,
      originalPrice: 80000,
    ),
    Product(
      id: '2',
      name: 'Chicken Teriyaki',
      description: 'Ayam panggang dengan saus teriyaki manis gurih, disajikan dengan nasi hangat dan taburan biji wijen.',
      price: 39000,
      imageUrl: 'https://img-global.cpcdn.com/steps/64cf167ed7725bb5/400x400cq80/photo.jpg',
      shopName: 'Chicken Bento',
      rating: 4.6,
      city: 'Jakarta Pusat',
      soldCount: 850,
      originalPrice: 50000,
    ),
    Product(
      id: '3',
      name: 'Nasi Goreng Spesial',
      description: 'Nasi goreng dengan bumbu khas rempah Indonesia, dilengkapi telur mata sapi, sosis, dan kerupuk renyah.',
      price: 25000,
      imageUrl: 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=500&q=80',
      shopName: 'Nasgor Cak Kumis',
      rating: 4.9,
      city: 'Surabaya',
      soldCount: 2500,
    ),
    Product(
      id: '4',
      name: 'Mie Ayam Bakso',
      description: 'Mie kenyal dengan potongan ayam kecap manis gurih, ditambah 2 buah bakso urat besar dan pangsit goreng.',
      price: 20000,
      imageUrl: 'https://i.gojekapi.com/darkroom/gofood-indonesia/v2/images/uploads/52f81f4d-4008-4293-a2e8-cbc4d2d98134_Go-Food-Merchant_20251011_081752.jpeg',
      shopName: 'Mie Ayam Wonogiri',
      rating: 4.7,
      city: 'Jakarta Timur',
      soldCount: 3000,
      originalPrice: 25000,
    ),
    Product(
      id: '5',
      name: 'Sate Ayam Madura',
      description: '10 tusuk sate ayam full daging panggang sempurna, disiram bumbu kacang kental khas Madura dan irisan bawang merah.',
      price: 30000,
      imageUrl: 'https://cdn.grid.id/crop/0x0:0x0/filters:format(webp):quality(100)/photo/sasefoto/original/24049-sate-ayam-madura.jpg',
      shopName: 'Sate H. Romli',
      rating: 4.8,
      city: 'Bandung',
      soldCount: 1500,
    ),
    Product(
      id: '6',
      name: 'Matcha Boba Milk',
      description: 'Minuman teh hijau Jepang premium dipadukan dengan susu segar dan boba brown sugar yang kenyal.',
      price: 28000,
      imageUrl: 'https://assets-a1.kompasiana.com/items/album/2025/10/17/macha-latte-68f1a27eed641567b0165272.png?t=o&v=770',
      shopName: 'Boba Time',
      rating: 4.5,
      city: 'Tangerang Selatan',
      soldCount: 500,
      originalPrice: 35000,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Row(
            children: const [
              SizedBox(width: 12),
              Icon(Icons.search, color: Color(0xFF94A3B8), size: 20),
              SizedBox(width: 8),
              Text(
                'Cari menu masakan...',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 13),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF1E293B)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _buildFilterChip('Promo', true),
                  _buildFilterChip('Pasti Diskon', false),
                  _buildFilterChip('Terdekat', false),
                  _buildFilterChip('Rating 4.5+', false),
                  _buildFilterChip('Sehat', false),
                ],
              ),
            ),
          ),
          Container(height: 1, color: const Color(0xFFE2E8F0)),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0, bottom: 100.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 320,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/detail',
                      arguments: product,
                    );
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  product.imageUrl,
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      _favoriteIds.contains(product.id) ? Icons.favorite : Icons.favorite_border,
                                      color: _favoriteIds.contains(product.id) ? const Color(0xFFEE2737) : const Color(0xFF94A3B8),
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (_favoriteIds.contains(product.id)) {
                                          _favoriteIds.remove(product.id);
                                        } else {
                                          _favoriteIds.add(product.id);
                                        }
                                      });
                                    },
                                    constraints: const BoxConstraints(),
                                    padding: const EdgeInsets.all(6),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFF59E0B), size: 12),
                            const SizedBox(width: 4),
                            Text(
                              product.rating.toString(),
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
                            ),
                            const SizedBox(width: 6),
                            const Text('•', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 11)),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                '${product.soldCount} terjual',
                                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${product.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          height: 32,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF00AA5B), width: 1.5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                color: Color(0xFF00AA5B),
                                fontSize: 13,
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF00AA5B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFF00AA5B) : const Color(0xFFE2E8F0),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF1E293B),
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}