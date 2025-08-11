import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clover UI – Final',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4A7334)),
        scaffoldBackgroundColor: const Color(0xFFF6F8F5),
      ),
      home: const HomePage(),
    );
  }
}

/* ================================ PALET & ASET ================================ */

class AppPalette {
  static const brandDark   = Color(0xFF4A7334); // hijau tua (brand)
  static const brandLight  = Color(0xFF96B25E); // hijau muda (brand)
  static const notchStroke = Color(0xFF2B2F28); // garis gelap tipis di bibir notch
  static const coinGold    = Color(0xFFF7E9A8); // chip koin
}

class BadgeAssets {
  // 4 badge sudut untuk grid (menempel di kartu)
  static const topLeft     = 'assets/clover/badge_top_left.png';     // 349×419
  static const topRight    = 'assets/clover/badge_top_right.png';    // 349×375
  static const bottomLeft  = 'assets/clover/badge_bottom_left.png';  // 349×375
  static const bottomRight = 'assets/clover/badge_bottom_right.png'; // 349×425
  // badge LEPAS untuk wide card (terpisah dari kartu)
  static const detachedBottomLeft = 'assets/clover/badge_detached_bottom_left.png'; // pakai bentuk BL
}

// rasio W/H asli PNG biar skala presisi
double badgeAspectFor(CloverCorner c) {
  switch (c) {
    case CloverCorner.topLeft:     return 349 / 419; // ≈ 0.833
    case CloverCorner.topRight:    return 349 / 375; // ≈ 0.931
    case CloverCorner.bottomLeft:  return 349 / 375; // ≈ 0.931
    case CloverCorner.bottomRight: return 349 / 425; // ≈ 0.821
  }
}

/* ================================== HALAMAN ================================== */

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final headerHeight = (h * 0.22).clamp(140.0, 190.0);
    const pagePadding = 20.0;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Scan cepat',
        child: const Icon(Icons.photo_camera),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header gradient
              SizedBox(
                height: headerHeight,
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
                    padding: const EdgeInsets.only(right: pagePadding, top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        CoinChip(amount: 1771),
                        SizedBox(width: 10),
                        _AvatarCircle(label: 'S'),
                        SizedBox(width: 8),
                        _AvatarCircle(label: 'K'),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Judul “Menu”
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: pagePadding),
                child: Row(
                  children: [
                    Text('Menu',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF234F2E),
                            )),
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

              // Grid 2×2 kartu clover (notch + badge menempel)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: pagePadding),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 0.98,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    CloverMenuCard(
                      corner: CloverCorner.topLeft,
                      badgePng: BadgeAssets.topLeft,
                      icon: Icons.photo_camera,
                      title: 'AI Vision',
                      subtitle: 'Scan sampah untuk mendapatkan penjelasan detail',
                    ),
                    CloverMenuCard(
                      corner: CloverCorner.topRight,
                      badgePng: BadgeAssets.topRight,
                      icon: Icons.location_on,
                      title: 'Geolokasi',
                      subtitle: 'Temukan tempat pembuangan sampah terdekat',
                    ),
                    CloverMenuCard(
                      corner: CloverCorner.bottomLeft,
                      badgePng: BadgeAssets.bottomLeft,
                      icon: Icons.hourglass_bottom_rounded,
                      title: 'Time Capsule',
                      subtitle: 'Ketahui dampak positif dan negatif dari sampah',
                    ),
                    CloverMenuCard(
                      corner: CloverCorner.bottomRight,
                      badgePng: BadgeAssets.bottomRight,
                      icon: Icons.attach_money_rounded,
                      title: 'Eco Reward',
                      subtitle: 'Kumpulkan poin dan tukar poinmu menjadi uang',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Wide card: notch kiri-bawah + badge LEPAS di bawah kiri
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: pagePadding),
                child: WideMenuCard(
                  title: 'Trash Chatbot',
                  subtitle: 'Tanyakan segala sesuatu tentang sampah melalui Trash Chatbot',
                  icon: Icons.support_agent,
                  badgePngDetached: BadgeAssets.detachedBottomLeft,
                ),
              ),
            ],
          ),
        ),
      ),

      // BottomAppBar + notch FAB di tengah
      bottomNavigationBar: BottomAppBar(
        shape: const AutomaticNotchedShape(
          RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        ),
        height: 66,
        notchMargin: 8,
        elevation: 8,
        color: Colors.white,
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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

/* ================================ KOMPONEN UI ================================ */

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
      child: Row(children: [
        const Icon(Icons.monetization_on, size: 20, color: Color(0xFF9C7A00)),
        const SizedBox(width: 6),
        Text(_format(amount), style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF6B5A00))),
      ]),
    );
  }
  static String _format(int n) {
    final s = n.toString().split('').reversed.toList();
    final out = <String>[];
    for (int i = 0; i < s.length; i++) { out.add(s[i]); if ((i + 1) % 3 == 0 && i + 1 != s.length) out.add(','); }
    return out.reversed.join();
  }
}

enum CloverCorner { topLeft, topRight, bottomLeft, bottomRight }

/* ------------------------------ Clover (grid) ------------------------------ */

class CloverMenuCard extends StatelessWidget {
  final CloverCorner corner;
  final String badgePng;
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const CloverMenuCard({
    super.key,
    required this.corner,
    required this.badgePng,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const cardRadius = 22.0;

    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth;
      final h = c.maxHeight > 0 ? c.maxHeight : 156.0;
      final shortSide = w < h ? w : h;

      // ukuran responsif
      final ratio       = badgeAspectFor(corner);
      final badgeW      = shortSide * 0.56;
      final badgeH      = badgeW / ratio;
      final notchRadius = shortSide * 0.195;
      final notchInset  = shortSide * 0.055;
      final badgeOverlap = -shortSide * 0.035;

      // padding konten menyesuaikan posisi notch
      final contentPad = switch (corner) {
        CloverCorner.topLeft || CloverCorner.topRight =>
          const EdgeInsets.fromLTRB(16, 58, 16, 14),
        CloverCorner.bottomLeft || CloverCorner.bottomRight =>
          const EdgeInsets.fromLTRB(16, 20, 16, 26),
      };

      // posisi badge + ikon
      Positioned placeBadge() {
        final badge = _BadgeWithIcon(
          path: badgePng,
          width: badgeW,
          height: badgeH,
          icon: icon,
          iconAlignment: switch (corner) {
            CloverCorner.topLeft     => const Alignment(-0.58, -0.40),
            CloverCorner.topRight    => const Alignment(0.58, -0.40),
            CloverCorner.bottomLeft  => const Alignment(-0.58, 0.55),
            CloverCorner.bottomRight => const Alignment(0.58, 0.55),
          },
        );
        switch (corner) {
          case CloverCorner.topLeft:
            return Positioned(left: badgeOverlap, top: badgeOverlap, child: badge);
          case CloverCorner.topRight:
            return Positioned(right: badgeOverlap, top: badgeOverlap, child: badge);
          case CloverCorner.bottomLeft:
            return Positioned(left: badgeOverlap, bottom: badgeOverlap, child: badge);
          case CloverCorner.bottomRight:
            return Positioned(right: badgeOverlap, bottom: badgeOverlap, child: badge);
        }
      }

      return InkWell(
        borderRadius: BorderRadius.circular(cardRadius),
        onTap: onTap,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              painter: _CloverCardPainter(
                corner: corner,
                cardRadius: cardRadius,
                notchRadius: notchRadius,
                notchInset: notchInset,
              ),
              child: SizedBox(height: h),
            ),
            Padding(
              padding: contentPad,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 2),
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 18, height: 1.1, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      subtitle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white.withOpacity(0.95), fontSize: 13, height: 1.25),
                    ),
                  ),
                ],
              ),
            ),
            placeBadge(),
          ],
        ),
      );
    });
  }
}

/* -------------------------- Painter badan kartu grid ------------------------- */

class _CloverCardPainter extends CustomPainter {
  final CloverCorner corner;
  final double cardRadius;
  final double notchRadius;
  final double notchInset;

  _CloverCardPainter({
    required this.corner,
    required this.cardRadius,
    required this.notchRadius,
    required this.notchInset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final baseRRect = RRect.fromRectAndRadius(rect, Radius.circular(cardRadius));
    final basePath  = Path()..addRRect(baseRRect);

    // pusat cekungan menurut sudut
    final c = switch (corner) {
      CloverCorner.topLeft     => Offset(notchInset + notchRadius, notchInset + notchRadius),
      CloverCorner.topRight    => Offset(size.width - notchInset - notchRadius, notchInset + notchRadius),
      CloverCorner.bottomLeft  => Offset(notchInset + notchRadius, size.height - notchInset - notchRadius),
      CloverCorner.bottomRight => Offset(size.width - notchInset - notchRadius, size.height - notchInset - notchRadius),
    };
    final notchOval = Rect.fromCircle(center: c, radius: notchRadius);
    final cut = Path.combine(PathOperation.difference, basePath, Path()..addOval(notchOval));

    // shadow + isi gradient
    canvas.drawShadow(cut, Colors.black26, 10, true);

    final fill = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft, end: Alignment.bottomRight,
        colors: [AppPalette.brandLight, AppPalette.brandDark],
      ).createShader(rect)
      ..isAntiAlias = true;
    canvas.drawPath(cut, fill);

    // highlight glossy di sudut berlawanan
    final hlCenter = switch (corner) {
      CloverCorner.topLeft     => Alignment(0.9, 0.9),
      CloverCorner.topRight    => Alignment(-0.9, 0.9),
      CloverCorner.bottomLeft  => Alignment(0.9, -0.9),
      CloverCorner.bottomRight => Alignment(-0.9, -0.9),
    };
    final hl = Paint()
      ..shader = RadialGradient(
        center: hlCenter, radius: 1.2,
        colors: [Colors.white.withOpacity(0), Colors.white.withOpacity(0.18)],
        stops: const [0.55, 1.0],
      ).createShader(rect);
    canvas.drawPath(cut, hl);

    // garis bibir notch (90°)
    const sweep = 3.141592653589793 / 2;
    final start = switch (corner) {
      CloverCorner.topLeft => 0.0,
      CloverCorner.topRight => sweep,
      CloverCorner.bottomRight => 3.141592653589793,
      CloverCorner.bottomLeft => sweep * 3,
    };
    final stroke = Paint()
      ..color = AppPalette.notchStroke
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..isAntiAlias = true;
    canvas.drawArc(notchOval, start, sweep, false, stroke);
  }

  @override
  bool shouldRepaint(covariant _CloverCardPainter old) =>
      old.corner != corner ||
      old.cardRadius != cardRadius ||
      old.notchRadius != notchRadius ||
      old.notchInset != notchInset;
}

/* --------------------------- Badge PNG + ikon putih -------------------------- */

class _BadgeWithIcon extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final IconData icon;
  final Alignment iconAlignment;

  const _BadgeWithIcon({
    required this.path,
    required this.width,
    required this.height,
    required this.icon,
    required this.iconAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, height: height,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(path, fit: BoxFit.contain, filterQuality: FilterQuality.high),
          Align(
            alignment: iconAlignment,
            child: Icon(icon, color: Colors.white, size: width * 0.22),
          ),
        ],
      ),
    );
  }
}

/* --------------------------------- WIDE CARD --------------------------------- */
// Notch kiri-bawah, dan badge LEPAS di bawah kiri (seperti referensi).
class WideMenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String badgePngDetached; // aset untuk badge lepas
  final VoidCallback? onTap;

  const WideMenuCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.badgePngDetached,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const r = 22.0;

    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth;
      final h = 120.0;                      // tinggi kartu
      final shortSide = w < h ? w : h;

      // rasio PNG badge lepas — pakai bentuk bottom-left (349×375)
      const detachedRatio = 349 / 375;
      final badgeW   = shortSide * 0.50;    // geser 0.46–0.54 kalau ingin beda rasa
      final badgeH   = badgeW / detachedRatio;
      final gap      = shortSide * 0.022;   // jarak antara kartu dan badge
      final notchR   = shortSide * 0.19;    // radius cekungan kartu
      final notchIn  = shortSide * 0.055;   // jarak cekungan dari tepi

      return Stack(
        clipBehavior: Clip.none,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(r),
            onTap: onTap,
            child: SizedBox(
              height: h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // badan kartu dipotong cekungan KIRI-BAWAH
                  CustomPaint(
                    painter: _CloverCardPainter(
                      corner: CloverCorner.bottomLeft,
                      cardRadius: r,
                      notchRadius: notchR,
                      notchInset: notchIn,
                    ),
                    child: const SizedBox.expand(),
                  ),
                  // highlight halus
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(r),
                        gradient: RadialGradient(
                          center: const Alignment(0.85, -0.85),
                          radius: 1.2,
                          colors: [Colors.white.withOpacity(0), Colors.white.withOpacity(0.16)],
                          stops: const [0.55, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // isi konten
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
                          child: Icon(icon, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  maxLines: 1, overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
                              const SizedBox(height: 6),
                              Text(subtitle,
                                  maxLines: 2, overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: Colors.white.withOpacity(0.95), height: 1.25)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // badge LEPAS di bawah kiri — tidak menempel ke kartu
          Positioned(
            left: gap,
            bottom: -(badgeH + gap),
            child: _BadgeWithIcon(
              path: badgePngDetached,
              width: badgeW,
              height: badgeH,
              icon: Icons.autorenew_rounded,   // ikon “sync/refresh”
              iconAlignment: const Alignment(-0.58, 0.55),
            ),
          ),
        ],
      );
    });
  }
}

/* --------------------------------- NAV BAWAH --------------------------------- */

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
          Text(label,
              style: TextStyle(fontSize: 11, color: color, fontWeight: active ? FontWeight.w800 : FontWeight.w500)),
        ],
      ),
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  final String label;
  const _AvatarCircle({required this.label});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: AppPalette.brandLight,
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800)),
      ),
    );
  }
}
