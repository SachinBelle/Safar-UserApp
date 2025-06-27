import 'package:flutter/material.dart';
import 'package:safar/constents/app_theme/text_theme/text_theme.dart';

class CustomNavBar extends StatefulWidget {
  final int initialIndex;
  final ValueChanged<int>? onTap;

  const CustomNavBar({super.key, this.initialIndex = 1, this.onTap});

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  int _selectedIndex = 1;

  static const double navBarHeight = 80;
  static const Color backgroundColor = Color(0xFFF5F6FA);
  static const Color selectedColor = Color(0xFFF4A261);
  static const Color defaultColor = Color(0xFF1D3557);

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }

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
    final bool isSelected = _selectedIndex == index;
    final Color itemColor = isSelected ? selectedColor : defaultColor;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
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
