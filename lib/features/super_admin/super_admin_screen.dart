import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuperAdminScreen extends StatefulWidget {
  const SuperAdminScreen({super.key});

  @override
  State<SuperAdminScreen> createState() => _SuperAdminScreenState();
}

class _SuperAdminScreenState extends State<SuperAdminScreen> {
  static const primary = Color(0xFF006B4F);
  static const bg = Color(0xFFF8FAFC);
  static const text = Color(0xFF101828);

  int selectedIndex = 0;
  String query = '';
  bool notifications = true;
  bool maintenance = false;

  final items = const [
    _MenuItem('Dashboard', Icons.home_rounded),
    _MenuItem('Foydalanuvchilar', Icons.people_alt_rounded),
    _MenuItem('Vakansiyalar', Icons.work_rounded),
    _MenuItem('Xorijda ish', Icons.public_rounded),
    _MenuItem('Arizalar', Icons.description_rounded),
    _MenuItem('Xabarlar', Icons.mail_outline_rounded, badge: '12'),
    _MenuItem('AI statistika', Icons.bar_chart_rounded),
    _MenuItem('To‘lovlar', Icons.payment_rounded),
    _MenuItem('Reklama boshqaruvi', Icons.campaign_rounded),
    _MenuItem('Sozlamalar', Icons.settings_rounded),
    _MenuItem('Tizim loglari', Icons.receipt_long_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.of(context).size.width >= 1050;

    return Scaffold(
      backgroundColor: bg,
      drawer: desktop
          ? null
          : Drawer(
              width: 300,
              child: _Sidebar(
                items: items,
                selectedIndex: selectedIndex,
                onChanged: (index) {
                  Navigator.pop(context);
                  setState(() => selectedIndex = index);
                },
              ),
            ),
      body: Row(
        children: [
          if (desktop)
            _Sidebar(
              items: items,
              selectedIndex: selectedIndex,
              onChanged: (index) => setState(() => selectedIndex = index),
            ),
          Expanded(
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    _TopBar(
                      query: query,
                      onQueryChanged: (value) => setState(() => query = value),
                      onMenu: desktop
                          ? null
                          : () => Scaffold.of(context).openDrawer(),
                      onFullscreen: () => _showSnack('Fullscreen demo rejimda'),
                      onNotifications: () =>
                          setState(() => notifications = !notifications),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(28),
                        children: [_content()],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _content() {
    if (selectedIndex == 0) {
      return _DashboardPage(onReport: () => _showSnack('Hisobot yuklandi'));
    }

    if (selectedIndex == 9) {
      return _SettingsPage(
        notifications: notifications,
        maintenance: maintenance,
        onNotifications: (value) => setState(() => notifications = value),
        onMaintenance: (value) => setState(() => maintenance = value),
        onLogout: () => _confirmLogout(),
      );
    }

    return _ManagementPage(
      title: items[selectedIndex].title,
      icon: items[selectedIndex].icon,
      query: query,
      onAction: () => _showSnack('${items[selectedIndex].title} yangilandi'),
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(backgroundColor: primary, content: Text(message)));
  }

  void _confirmLogout() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chiqish'),
        content: const Text('Super admin paneldan chiqmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Bekor qilish'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text('Chiqish'),
          ),
        ],
      ),
    );
  }
}

class _MenuItem {
  const _MenuItem(this.title, this.icon, {this.badge});

  final String title;
  final IconData icon;
  final String? badge;
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  final List<_MenuItem> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(22),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF004D3A), Color(0xFF002E24)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.work_rounded, color: Colors.white, size: 34),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Workora',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      'Super Admin Panel',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final active = selectedIndex == index;
                return InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: () => onChanged(index),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: active
                          ? const Color(0xFF0FA87A)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Icon(item.icon, color: Colors.white),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        if (item.badge != null)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFF10B981),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              item.badge!,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w900,
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
          const _AiHelperCard(),
          const SizedBox(height: 16),
          const _AdminProfileCard(),
          const SizedBox(height: 16),
          InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => context.go('/login'),
            child: Container(
              height: 56,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Chiqish',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
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
}

class _AiHelperCard extends StatelessWidget {
  const _AiHelperCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .08),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Row(
        children: [
          CircleAvatar(child: Icon(Icons.smart_toy_rounded)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'AI yordamchisi\nStatistika va tavsiyalar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdminProfileCard extends StatelessWidget {
  const _AdminProfileCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .07),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          CircleAvatar(child: Icon(Icons.person)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Super Admin\nsuperadmin@workora.uz',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.query,
    required this.onQueryChanged,
    required this.onFullscreen,
    required this.onNotifications,
    this.onMenu,
  });

  final String query;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback onFullscreen;
  final VoidCallback onNotifications;
  final VoidCallback? onMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      color: Colors.white,
      child: Row(
        children: [
          IconButton(onPressed: onMenu, icon: const Icon(Icons.menu_rounded)),
          const SizedBox(width: 18),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: TextField(
              onChanged: onQueryChanged,
              decoration: InputDecoration(
                hintText: 'Qidirish...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Center(
                    widthFactor: 1,
                    child: Text(
                      'Ctrl + K',
                      style: TextStyle(color: Color(0xFF667085), fontSize: 12),
                    ),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                ),
              ),
            ),
          ),
          const Spacer(),
          _IconBox(icon: Icons.fullscreen_rounded, onTap: onFullscreen),
          const SizedBox(width: 14),
          Stack(
            children: [
              _IconBox(
                icon: Icons.notifications_none_rounded,
                onTap: onNotifications,
              ),
              Positioned(
                right: 6,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0FA87A),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '5',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 18),
          const CircleAvatar(child: Icon(Icons.person)),
          const SizedBox(width: 12),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Super Admin',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              Text(
                'Super Administrator',
                style: TextStyle(
                  color: Color(0xFF006B4F),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFE5E7EB)),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon),
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage({required this.onReport});

  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PageTitle(onReport: onReport),
        const SizedBox(height: 24),
        const _StatsRow(),
        const SizedBox(height: 24),
        const _ChartsRow(),
        const SizedBox(height: 24),
        const _MiddleRow(),
        const SizedBox(height: 24),
        const _BottomStats(),
      ],
    );
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.onReport});

  final VoidCallback onReport;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const SizedBox(
          width: 520,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xush kelibsiz, Super Admin!',
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 8),
              Text(
                'Bugungi platforma statistikasi va faoliyat holati',
                style: TextStyle(
                  color: Color(0xFF667085),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const _SmallButton(
          text: 'Bugun: 18 may, 2025',
          icon: Icons.calendar_month_rounded,
        ),
        _SmallButton(
          text: 'Hisobot yuklash',
          icon: Icons.download_rounded,
          dark: true,
          onTap: onReport,
        ),
      ],
    );
  }
}

class _SmallButton extends StatelessWidget {
  const _SmallButton({
    required this.text,
    required this.icon,
    this.dark = false,
    this.onTap,
  });

  final String text;
  final IconData icon;
  final bool dark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF006B4F) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: dark ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: dark ? Colors.white : const Color(0xFF101828),
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: dark ? Colors.white : const Color(0xFF101828),
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return const _Horizontal(
      minWidth: 1180,
      child: Row(
        children: [
          Expanded(
            child: _StatCard(
              title: 'Jami foydalanuvchilar',
              value: '12,856',
              change: '+256 bu hafta',
              icon: Icons.people_alt_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _StatCard(
              title: 'Faol vakansiyalar',
              value: '1,248',
              change: '+84 bu hafta',
              icon: Icons.work_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _StatCard(
              title: 'Jami arizalar',
              value: '8,542',
              change: '+312 bu hafta',
              icon: Icons.description_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _StatCard(
              title: 'AI so‘rovlar',
              value: '24,856',
              change: '+1,256 bu hafta',
              icon: Icons.smart_toy_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _StatCard(
              title: 'Platforma daromadi',
              value: '\$45,782',
              change: '+12.5% bu oy',
              icon: Icons.attach_money_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.change,
    required this.icon,
  });

  final String title;
  final String value;
  final String change;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          _CircleIcon(icon: icon),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  change,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF006B4F),
                    fontWeight: FontWeight.w800,
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

class _ChartsRow extends StatelessWidget {
  const _ChartsRow();

  @override
  Widget build(BuildContext context) {
    return const _Horizontal(
      minWidth: 1120,
      child: Row(
        children: [
          Expanded(flex: 2, child: _LineChartCard()),
          SizedBox(width: 18),
          Expanded(child: _BarChartCard()),
          SizedBox(width: 18),
          Expanded(child: _PieChartCard()),
        ],
      ),
    );
  }
}

class _LineChartCard extends StatelessWidget {
  const _LineChartCard();

  @override
  Widget build(BuildContext context) {
    final heights = [90, 130, 110, 160, 120, 150, 190];

    return _Panel(
      height: 300,
      title: 'Arizalar statistikasi',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: heights
            .map(
              (height) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: height.toDouble(),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFEAF8F1), Color(0xFF0FA87A)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BarChartCard extends StatelessWidget {
  const _BarChartCard();

  @override
  Widget build(BuildContext context) {
    final bars = [110, 150, 165, 185, 220];

    return _Panel(
      height: 300,
      title: 'Foydalanuvchilar o‘sishi',
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: bars
            .map(
              (height) => Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  height: height.toDouble(),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0FA87A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PieChartCard extends StatelessWidget {
  const _PieChartCard();

  @override
  Widget build(BuildContext context) {
    return _Panel(
      height: 300,
      title: 'Arizalar holati',
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFF006B4F),
                  Color(0xFF0FA87A),
                  Color(0xFFF59E0B),
                  Color(0xFFEF4444),
                  Color(0xFF006B4F),
                ],
              ),
            ),
            child: Center(
              child: Container(
                width: 76,
                height: 76,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '8,542\nJami',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Legend(text: 'Ko‘rib chiqilmoqda', color: Color(0xFF006B4F)),
                _Legend(text: 'Intervyu', color: Color(0xFF0FA87A)),
                _Legend(text: 'Qabul qilingan', color: Color(0xFFF59E0B)),
                _Legend(text: 'Rad etilgan', color: Color(0xFFEF4444)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiddleRow extends StatelessWidget {
  const _MiddleRow();

  @override
  Widget build(BuildContext context) {
    return const _Horizontal(
      minWidth: 1160,
      child: Row(
        children: [
          Expanded(flex: 2, child: _VacanciesTable()),
          SizedBox(width: 18),
          Expanded(child: _ActivityPanel()),
          SizedBox(width: 18),
          Expanded(child: _CompaniesPanel()),
        ],
      ),
    );
  }
}

class _VacanciesTable extends StatelessWidget {
  const _VacanciesTable();

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['Flutter Developer', 'Tech Solutions LLC', 'Toshkent', '24', 'Faol'],
      ['UI/UX Designer', 'Creative Agency', 'Toshkent', '18', 'Faol'],
      ['Backend Developer', 'CodeLab Inc.', 'Samarqand', '32', 'Faol'],
      ['Marketing Manager', 'Market Plus', 'Toshkent', '15', 'Draft'],
      ['Sales Manager', 'Global Soft', 'Buxoro', '27', 'Faol'],
    ];

    return _Panel(
      height: 310,
      title: 'So‘nggi vakansiyalar',
      child: Column(
        children: rows
            .map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        row[0],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                    Expanded(
                      child: Text(row[1], overflow: TextOverflow.ellipsis),
                    ),
                    Expanded(
                      child: Text(row[2], overflow: TextOverflow.ellipsis),
                    ),
                    Expanded(child: Text(row[3])),
                    _StatusChip(text: row[4]),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _ActivityPanel extends StatelessWidget {
  const _ActivityPanel();

  @override
  Widget build(BuildContext context) {
    final items = [
      'Yangi foydalanuvchi qo‘shildi',
      'Yangi vakansiya qo‘shildi',
      'Ariza qabul qilindi',
      'Foydalanuvchi tasdiqlandi',
      'Xabar kelib tushdi',
    ];

    return _Panel(
      height: 310,
      title: 'So‘nggi faoliyat',
      child: Column(
        children: items
            .map(
              (item) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const _SmallCircleIcon(
                  icon: Icons.event_available_rounded,
                ),
                title: Text(
                  item,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                subtitle: const Text('Bugun'),
                trailing: const Text('10:30'),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CompaniesPanel extends StatelessWidget {
  const _CompaniesPanel();

  @override
  Widget build(BuildContext context) {
    final companies = [
      ['Tech Solutions LLC', '48 ta vakansiya'],
      ['Creative Agency', '32 ta vakansiya'],
      ['CodeLab Inc.', '28 ta vakansiya'],
      ['Market Plus', '21 ta vakansiya'],
      ['Global Soft', '18 ta vakansiya'],
    ];

    return _Panel(
      height: 310,
      title: 'Top kompaniyalar',
      child: Column(
        children: companies
            .map(
              (company) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: Color(0xFFEAF8F1),
                  child: Icon(Icons.business, color: Color(0xFF006B4F)),
                ),
                title: Text(
                  company[0],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                trailing: Text(company[1]),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _BottomStats extends StatelessWidget {
  const _BottomStats();

  @override
  Widget build(BuildContext context) {
    return const _Horizontal(
      minWidth: 1160,
      child: Row(
        children: [
          Expanded(
            child: _MiniStat(
              title: 'Profil to‘ldirish darajasi',
              value: '78%',
              icon: Icons.donut_large_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _MiniStat(
              title: 'Aktiv foydalanuvchilar',
              value: '6,542',
              icon: Icons.people_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _MiniStat(
              title: 'O‘rtacha ariza soni',
              value: '3.6',
              icon: Icons.send_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _MiniStat(
              title: 'AI moslik darajasi',
              value: '85%',
              icon: Icons.smart_toy_rounded,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _MiniStat(
              title: 'Platforma holati',
              value: 'A’lo',
              icon: Icons.verified_user_rounded,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(18),
      decoration: _cardDecoration(),
      child: Row(
        children: [
          _SmallCircleIcon(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF667085),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF006B4F),
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

class _ManagementPage extends StatelessWidget {
  const _ManagementPage({
    required this.title,
    required this.icon,
    required this.query,
    required this.onAction,
  });

  final String title;
  final IconData icon;
  final String query;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ['Workora Basic', 'Active', '12,856'],
      ['Employer Premium', 'Active', '1,248'],
      ['Global Program', 'Draft', '842'],
      ['AI Campaign', 'Active', '24,856'],
    ].where((row) => row.join(' ').toLowerCase().contains(query.toLowerCase()));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _CircleIcon(icon: icon),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: _SuperAdminScreenState.text,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            _SmallButton(
              text: 'Yangilash',
              icon: Icons.refresh_rounded,
              dark: true,
              onTap: onAction,
            ),
          ],
        ),
        const SizedBox(height: 22),
        _Panel(
          height: 420,
          title: '$title boshqaruvi',
          child: Column(
            children: [
              for (final row in rows)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          row[0],
                          style: const TextStyle(fontWeight: FontWeight.w900),
                        ),
                      ),
                      Expanded(child: _StatusChip(text: row[1])),
                      Expanded(child: Text(row[2])),
                      IconButton(
                        onPressed: onAction,
                        icon: const Icon(Icons.edit_rounded),
                      ),
                      IconButton(
                        onPressed: onAction,
                        icon: const Icon(Icons.delete_outline_rounded),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage({
    required this.notifications,
    required this.maintenance,
    required this.onNotifications,
    required this.onMaintenance,
    required this.onLogout,
  });

  final bool notifications;
  final bool maintenance;
  final ValueChanged<bool> onNotifications;
  final ValueChanged<bool> onMaintenance;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sozlamalar',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 22),
        _Panel(
          height: 320,
          title: 'Super admin sozlamalari',
          child: Column(
            children: [
              SwitchListTile(
                value: notifications,
                onChanged: onNotifications,
                title: const Text('Bildirishnomalar'),
                subtitle: const Text('Admin xabarlarini olish'),
                activeThumbColor: const Color(0xFF006B4F),
              ),
              SwitchListTile(
                value: maintenance,
                onChanged: onMaintenance,
                title: const Text('Maintenance mode'),
                subtitle: const Text(
                  'Platformani vaqtincha texnik rejimga olish',
                ),
                activeThumbColor: const Color(0xFF006B4F),
              ),
              const ListTile(
                leading: Icon(Icons.security_rounded),
                title: Text('Ruxsatlar'),
                subtitle: Text('Admin rollari va permissionlar'),
              ),
              ListTile(
                leading: const Icon(Icons.logout_rounded),
                title: const Text('Chiqish'),
                subtitle: const Text('Super admin paneldan chiqish'),
                onTap: onLogout,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Panel extends StatelessWidget {
  const _Panel({
    required this.title,
    required this.child,
    required this.height,
  });

  final String title;
  final Widget child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(22),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Horizontal extends StatelessWidget {
  const _Horizontal({required this.child, required this.minWidth});

  final Widget child;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(width: minWidth, child: child),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0FA87A), Color(0xFF004D3A)],
        ),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white),
    );
  }
}

class _SmallCircleIcon extends StatelessWidget {
  const _SmallCircleIcon({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: const Color(0xFFEAF8F1),
      child: Icon(icon, color: const Color(0xFF006B4F), size: 20),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(radius: 5, backgroundColor: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final draft = text == 'Draft';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: draft ? const Color(0xFFFFF4D6) : const Color(0xFFDDF8EC),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: draft ? const Color(0xFFB45309) : const Color(0xFF006B4F),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

BoxDecoration _cardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: const Color(0xFFE5E7EB)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: .035),
        blurRadius: 18,
        offset: const Offset(0, 8),
      ),
    ],
  );
}
