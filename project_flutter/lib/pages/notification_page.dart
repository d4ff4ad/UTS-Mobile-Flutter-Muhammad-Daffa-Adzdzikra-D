import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 0, // Sembunyikan bagian title karena ditangani MainScreen
          bottom: const TabBar(
            labelColor: Color(0xFF00AA5B),
            unselectedLabelColor: Color(0xFF94A3B8),
            indicatorColor: Color(0xFF00AA5B),
            indicatorWeight: 3,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            tabs: [
              Tab(text: 'Promo'),
              Tab(text: 'Transaksi'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPromoList(),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoList() {
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      children: [
        _buildNotificationCard(
          title: 'Diskon kilat DafFood s.d. 60%',
          description: 'Cepat! Pakai vouchernya sebelum kehabisan untuk pesan makan siang enak hari ini.',
          time: '1 jam yang lalu',
          icon: Icons.restaurant,
          iconColor: const Color(0xFFEE2737),
          isUnread: true,
        ),
        _buildNotificationCard(
          title: 'Cashback 50.000 dari DafPay',
          description: 'Top up saldo kamu minimal Rp100.000 bulan ini dan dapatkan cashback instan.',
          time: '3 jam yang lalu',
          icon: Icons.account_balance_wallet,
          iconColor: const Color(0xFF0081A0),
          isUnread: true,
        ),
        _buildNotificationCard(
          title: 'Gratis Ongkir DafSend',
          description: 'Kirim paket kemana aja jadi tebus murah. Nikmati gratis ongkir sampai Rp20.000.',
          time: '1 hari yang lalu',
          icon: Icons.local_shipping,
          iconColor: const Color(0xFF00AA5B),
          isUnread: false,
        ),
        _buildNotificationCard(
          title: 'Promo Spesial Anak Sultan',
          description: 'Karena kamu sudah capai level Anak Sultan, nikmati diskon eksklusif 25% di DafRide.',
          time: '2 hari yang lalu',
          icon: Icons.star,
          iconColor: const Color(0xFF6A35FF),
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildTransactionList() {
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      children: [
        _buildNotificationCard(
          title: 'Pesanan DafFood Selesai',
          description: 'Pesanan Sushi Mentai kamu dari Sushi Hub sudah tiba. Suka dengan makanannya? Beri rating yuk!',
          time: '12:45',
          icon: Icons.check_circle,
          iconColor: const Color(0xFF00AA5B),
          isUnread: true,
        ),
        _buildNotificationCard(
          title: 'Top Up DafPay Berhasil',
          description: 'Top Up sebesar Rp 100.000 melalui M-Banking telah masuk ke saldo DafPay kamu.',
          time: 'Kemarin 08:30',
          icon: Icons.receipt_long,
          iconColor: const Color(0xFF0081A0),
          isUnread: false,
        ),
        _buildNotificationCard(
          title: 'Perjalanan DafRide Selesai',
          description: 'Terima kasih telah berkendara bersama Dafjek! Total tarif Rp 15.000 telah dibayar dengan DafPay.',
          time: '20 Mei 15:20',
          icon: Icons.two_wheeler,
          iconColor: const Color(0xFF00AA5B),
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildNotificationCard({
    required String title,
    required String description,
    required String time,
    required IconData icon,
    required Color iconColor,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isUnread ? const Color(0xFFE2E8F0) : Colors.transparent,
        ),
        boxShadow: isUnread
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.only(top: 4, left: 8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEE2737),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}