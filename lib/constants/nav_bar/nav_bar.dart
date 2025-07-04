import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/presentation/pages/notification_page.dart';
import 'package:safar/presentation/pages/profile_page.dart';
import 'package:safar/presentation/pages/home screen/homescreen_page.dart';

class CustomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onTap;

  const CustomNavBar({Key? key, required this.selectedIndex, this.onTap})
    : super(key: key);

  static const double navBarHeight = 80;
  static const Color backgroundColor = Color(0xFFF5F6FA);
  static const Color selectedColor = Color(0xFFF4A261);
  static const Color defaultColor = Color(0xFF1D3557);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemWidth = screenWidth / 3;
    return SizedBox(
      width: screenWidth,
      height: navBarHeight,
      child: Container(
        color: backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              icon: Icons.notifications,
              label: 'Noticeboard',
              index: 0,
              width: itemWidth,
            ),
            _buildNavItem(
              icon: Icons.home,
              label: 'Home',
              index: 1,
              width: itemWidth,
            ),
            _buildNavItem(
              icon: Icons.person,
              label: 'Profile',
              index: 2,
              width: itemWidth,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required double width,
  }) {
    final bool isSelected = selectedIndex == index;
    final Color itemColor = isSelected ? selectedColor : defaultColor;
    return GestureDetector(
      onTap: () => onTap?.call(index),
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: itemColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.navbarButtonText.copyWith(color: itemColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarDemoPage extends StatefulWidget {
  const NavBarDemoPage({Key? key}) : super(key: key);

  @override
  State<NavBarDemoPage> createState() => _NavBarDemoPageState();
}

class _NavBarDemoPageState extends State<NavBarDemoPage> {
  int _selectedIndex = 1;

  static final List<Widget> _pages = <Widget>[
    NotificationPage(),
    HomescreenPage(),
    ProfilePage(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onNavBarTap,
      ),
    );
  }
}
