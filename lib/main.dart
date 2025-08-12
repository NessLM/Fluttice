// lib/main.dart
// Clover UI — PNG sebagai BACKGROUND penuh; tipografi diperkecil; ikon sudut metrik.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

/* ------------------------------- tema & aset ------------------------------ */

class AppPalette {
  static const brandDark  = Color(0xFF4A7334);
  static const brandLight = Color(0xFF96B25E);
  static const coinGold   = Color(0xFFF7E9A8);
}

class BadgeAssets {
  static const topLeft     = 'assets/clover/badge_top_left.png';
  static const topRight    = 'assets/clover/badge_top_right.png';
  static const bottomLeft  = 'assets/clover/badge_bottom_left.png';
  static const bottomRight = 'assets/clover/badge_bottom_right.png';
  static const detachedBL  = 'assets/clover/badge_detached_bottom_left.png'; // opsi kartu lebar
}

const double kPagePadding = 20.0;

/* --------------------------------- app ---------------------------------- */

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clover UI (PNG background)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppPalette.brandDark),
        scaffoldBackgroundColor: const Color(0xFFF6F8F5),
      ),
      home: const HomePage(),
    );
  }
}

/* -------------------------------- halaman -------------------------------- */

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final headerH = (h * 0.22).clamp(140.0, 190.0);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Scan cepat',
        child: const Icon(Icons.photo_camera),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: komposisi ikon seperti mockup (koin kiri, avatar kanan)
              SizedBox(
                height: headerH,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft, end: Alignment.bottomRight,
                      colors: [AppPalette.brandLight, AppPalette.brandDark],
                    ),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 6))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPagePadding).copyWith(top: 16),
                    child: Row(
                      children: const [
                        CoinChip(amount: 1771),
                        Spacer(),
                        _AvatarCircle(label: 'S'),
                        SizedBox(width: 8),
                        _AvatarCircle(label: 'K'),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Judul “Menu” + garis tipis
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
                child: Row(
                  children: [
                    Text(
                      'Menu',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF234F2E),
                          ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: const Color(0xFF234F2E).withOpacity(0.25),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Grid 2×2 — kartu PNG penuh
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPagePadding),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.98,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: const [
                    CloverImageCard(
                      corner: CloverCorner.topLeft,
                      backgroundPng: BadgeAssets.topLeft,
                      icon: Icons.photo_camera,
                      title: 'Trash Vision',
                      subtitle: 'Scan sampah untuk mendapatkan penjelasan detail',
                    ),
                    CloverImageCard(
                      corner: CloverCorner.topRight,
                      backgroundPng: BadgeAssets.topRight,
                      icon: Icons.location_on,
                      title: 'Trash Location',
                      subtitle: 'Temukan tempat pembuangan sampah terdekat',
                    ),
                    CloverImageCard(
                      corner: CloverCorner.bottomLeft,
                      backgroundPng: BadgeAssets.bottomLeft,
                      icon: Icons.hourglass_bottom_rounded,
                      title: 'Trash Capsule',
                      subtitle: 'Ketahui dampak positif dan negatif dari penanganan sampah',
                    ),
                    CloverImageCard(
                      corner: CloverCorner.bottomRight,
                      backgroundPng: BadgeAssets.bottomRight,
                      icon: Icons.attach_money_rounded,
                      title: 'Trash Reward',
                      subtitle: 'Kumpulkan poin dan tukar lencana dan uang',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Kartu lebar — PNG penuh
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: kPagePadding),
                child: WideImageCard(
                  title: 'Trash Chatbot',
                  subtitle: 'Tanyakan segala sesuatu tentang sampah melalui Trash Chatbot',
                  icon: Icons.support_agent,
                  backgroundPng: BadgeAssets.detachedBL, // pakai bottomLeft jika aset ini belum ada
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        ),
        elevation: 8,
        height: 66,
        notchMargin: 8,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _NavIcon(icon: Icons.home_rounded, label: 'Home', active: true),
              _NavIcon(icon: Icons.history_rounded, label: 'Scan'),
              SizedBox(width: 48),
              _NavIcon(icon: Icons.chat_bubble_rounded, label: 'Chat'),
              _NavIcon(icon: Icons.person_rounded, label: 'Me'),
            ],
          ),
        ),
      ),
    );
  }
}

/* ------------------------------- komponen kecil --------------------------- */

class CoinChip extends StatelessWidget {
  final int amount;
  const CoinChip({super.key, required this.amount});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppPalette.coinGold,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5D27A)),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Row(
        children: [
          const Icon(Icons.monetization_on, size: 20, color: Color(0xFF9C7A00)),
          const SizedBox(width: 6),
          Text(
            _format(amount),
            style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6B5A00)),
          ),
        ],
      ),
    );
  }

  static String _format(int n) {
    final s = n.toString().split('').reversed.toList();
    final out = <String>[];
    for (int i = 0; i < s.length; i++) {
      out.add(s[i]);
      if ((i + 1) % 3 == 0 && i + 1 != s.length) out.add(',');
    }
    return out.reversed.join();
  }
}

class _AvatarCircle extends StatelessWidget {
  final String label;
  const _AvatarCircle({required this.label});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16, backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 14, backgroundColor: AppPalette.brandLight,
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

/* ------------------------------ Kartu PNG penuh -------------------------- */

enum CloverCorner { topLeft, topRight, bottomLeft, bottomRight }

class CloverImageCard extends StatelessWidget {
  final CloverCorner corner;
  final String backgroundPng;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CloverImageCard({
    super.key,
    required this.corner,
    required this.backgroundPng,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 22.0;

    return LayoutBuilder(
      builder: (context, c) {
        final w = c.maxWidth;
        final h = (c.hasBoundedHeight && c.maxHeight.isFinite && c.maxHeight > 0)
            ? c.maxHeight
            : w / 0.98; // selaras dengan childAspectRatio grid

        // ukuran berbasis sisi pendek → ikon & margin konsisten di semua device
        final shortSide = w < h ? w : h;
        final iconSize   = shortSide * 0.18;     // kira-kira 26–30px di ponsel umum
        final iconInset  = shortSide * 0.085;    // jarak dari tepi agar “nempel” tapi tidak nabrak

        // padding konten: notch di atas perlu atap lebih tebal
        final EdgeInsets contentPad =
            (corner == CloverCorner.topLeft || corner == CloverCorner.topRight)
                ? const EdgeInsets.fromLTRB(16, 52, 16, 14)
                : const EdgeInsets.fromLTRB(16, 18, 16, 24);

        // posisi ikon sudut secara metrik, bukan alignment relatif
        double? left, right, top, bottom;
        switch (corner) {
          case CloverCorner.topLeft:
            left = iconInset;  top = iconInset;  break;
          case CloverCorner.topRight:
            right = iconInset; top = iconInset;  break;
          case CloverCorner.bottomLeft:
            left = iconInset;  bottom = iconInset; break;
          case CloverCorner.bottomRight:
            right = iconInset; bottom = iconInset; break;
        }

        return InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 6))],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      backgroundPng,
                      fit: BoxFit.cover,            // PNG benar-benar jadi background
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  Padding(
                    padding: contentPad,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          softWrap: true,
                          // lebih kecil dari sebelumnya agar tidak padat
                          style: const TextStyle(
                            color: Colors.white, fontSize: 16, height: 1.1, fontWeight: FontWeight.w900,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Expanded(
                          child: Text(
                            subtitle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.96),
                              fontSize: 12.0, height: 1.3, // diperkecil + line-height ditambah
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: left, right: right, top: top, bottom: bottom,
                    child: Container(
                      width: iconSize, height: iconSize,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: iconSize * 0.57, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/* ------------------------------ Kartu lebar PNG -------------------------- */

class WideImageCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String backgroundPng;
  final VoidCallback? onTap;

  const WideImageCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundPng,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 22.0;
    const h = 112.0;

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: onTap,
      child: Container(
        height: h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 6))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  backgroundPng,
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 14),
                child: Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Trash Chatbot',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 0.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white.withOpacity(0.96), height: 1.3, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // titik ikon kecil di bagian notch bawah kiri seperti mockup
              Positioned(
                left: 14, bottom: 18,
                child: Container(
                  width: 28, height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.refresh_rounded, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* ------------------------------- bottom nav ------------------------------ */

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  const _NavIcon({required this.icon, required this.label, this.active = false});

  @override
  Widget build(BuildContext context) {
    final color = active ? AppPalette.brandDark : Colors.black54;
    return InkResponse(
      radius: 28,
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: color, fontWeight: active ? FontWeight.w800 : FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
