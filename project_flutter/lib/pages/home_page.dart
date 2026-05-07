import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true, // Penting agar body berada di belakang bottom nav bar (efek melayang)
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 100.0), // Padding bawah ekstra untuk nav bar
          children: [
            _buildHeader(context),
            const SizedBox(height: 16),
            _buildDafPayCard(),
            const SizedBox(height: 24),
            _buildServicesGrid(context), // Mengirim context untuk menghitung lebar layar
            const SizedBox(height: 32), // Jarak dirapikan
            _buildPromos(),
            const SizedBox(height: 32),
            _buildVouchers(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 24), // Margin agar melayang
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30), // Pill shape
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF00AA13),
            unselectedItemColor: Colors.grey,
            currentIndex: 0,
            backgroundColor: Colors.white,
            elevation: 0, // Hilangkan elevation bawaan karena sudah pakai shadow di Container
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Katalog'),
              BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifikasi'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
            ],
            onTap: (index) {
              if (index == 3) {
                Navigator.pushNamed(context, '/profile');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Cari layanan, makanan, & tujuan',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                fillColor: Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/profile'),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade200,
            child: const Icon(Icons.person, color: Colors.grey),
          ),
        ),
      ],
    );
  }

  Widget _buildDafPayCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0081A0), // Warna Teal DafPay
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'dafpay',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Rp 125.000',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 4),
              const Text(
                'Klik & cek riwayat',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
          Row(
            children: [
              _buildPayAction(Icons.arrow_upward, 'Bayar'),
              const SizedBox(width: 12),
              _buildPayAction(Icons.add, 'Top Up'),
              const SizedBox(width: 12),
              _buildPayAction(Icons.explore, 'Eksplor'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPayAction(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF0081A0), size: 20),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  // Menggunakan Wrap agar tinggi proporsional dan tidak ada space berlebih seperti GridView
  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {'title': 'DafRide', 'icon': Icons.motorcycle, 'color': const Color(0xFF00AA13), 'bg': const Color(0xFFE5F6EB)},
      {'title': 'DafCar', 'icon': Icons.directions_car, 'color': const Color(0xFF00AA13), 'bg': const Color(0xFFE5F6EB)},
      {'title': 'DafFood', 'icon': Icons.restaurant, 'color': const Color(0xFFEE2737), 'bg': const Color(0xFFFCEBEA)},
      {'title': 'DafSend', 'icon': Icons.local_shipping, 'color': const Color(0xFF00AA13), 'bg': const Color(0xFFE5F6EB)},
      {'title': 'DafMart', 'icon': Icons.shopping_cart, 'color': const Color(0xFFEE2737), 'bg': const Color(0xFFFCEBEA)},
      {'title': 'DafPulsa', 'icon': Icons.smartphone, 'color': const Color(0xFF00AED6), 'bg': const Color(0xFFE5F0FA)},
      {'title': 'DafClub', 'icon': Icons.star, 'color': const Color(0xFF93328E), 'bg': const Color(0xFFEAE3F6)},
      {'title': 'Lainnya', 'icon': Icons.more_horiz, 'color': const Color(0xFF8C8C8C), 'bg': const Color(0xFFF2F2F2)},
    ];

    // Menghitung lebar 1 item (1/4 dari lebar layar dikurangi padding/margin)
    double itemWidth = (MediaQuery.of(context).size.width - 32) / 4;

    return Wrap(
      spacing: 0,
      runSpacing: 20, // Jarak vertikal antar baris yang proporsional
      children: services.map((s) {
        return SizedBox(
          width: itemWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: s['bg'] as Color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  s['icon'] as IconData,
                  color: s['color'] as Color,
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                s['title'] as String,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPromos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Akses cepat buat kamu',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 140, // Tinggi diperbesar sedikit agar teks tidak sempit
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _buildPromoCard(
                'Diskon s.d. 50%',
                'Khusus pengguna baru DafFood & DafRide',
                const Color(0xFF0081A0),
                'Pesan Sekarang',
              ),
              const SizedBox(width: 16),
              _buildPromoCard(
                'Cashback 50 Rb',
                'Top up DafPay min. 100rb minggu ini',
                const Color(0xFF4A3BB9),
                'Top Up DafPay',
              ),
              const SizedBox(width: 16),
              _buildPromoCard(
                'Gratis Ongkir',
                'Kirim barang pakai DafSend',
                const Color(0xFFFF9900),
                'Cek Promo',
              ),
              const SizedBox(width: 16),
              _buildPromoCard(
                'Promo Spesial',
                'Tukar koin DafClub kamu sekarang',
                const Color(0xFFE91E63),
                'Tukar Koin',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPromoCard(String title, String subtitle, Color color, String btnText) {
    return Container(
      width: 260,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 12)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(btnText, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildVouchers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kode Voucher Spesial Dafjek',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        _buildVoucherCard(
          'PENGGUNA BARU',
          'Diskon DafFood 50% hingga Rp30.000',
          const [Color(0xFFEE2737), Color(0xFFFF9900)],
        ),
        const SizedBox(height: 16),
        _buildVoucherCard(
          'WEEKEND CERIA',
          'Cashback DafRide 10.000 Coins',
          const [Color(0xFF00AA13), Color(0xFF00C853)],
        ),
        const SizedBox(height: 16),
        _buildVoucherCard(
          'ONGKIR GRATIS',
          'Kirim paket DafSend gratis ongkir',
          const [Color(0xFF4A3BB9), Color(0xFF7E57C2)],
        ),
      ],
    );
  }

  Widget _buildVoucherCard(String title, String subtitle, List<Color> gradientColors) {
    return Container(
      width: double.infinity,
      height: 140, // Height dibuat proporsional
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24), // Padding diatur agar isi lebih lega
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: Colors.white, fontSize: 15)),
        ],
      ),
    );
  }
}
