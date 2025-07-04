import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/constants/app_theme/colour_theme/colour_theme.dart';
import 'package:safar/constants/app_theme/button_theme/responsive_button.dart';
import 'package:safar/constants/nav_bar/nav_bar.dart';
import 'package:safar/presentation/pages/edit profile page/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  // Accept user data from backend
  final String userName;
  final String userPhone;
  final String userAvatarUrl;

  const ProfilePage({
    Key? key,
    this.userName = 'Sachin Belle',
    this.userPhone = '+91 111223333',
    this.userAvatarUrl = 'https://randomuser.me/api/portraits/men/32.jpg',
  }) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationsOn = true;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth > 370 ? 343 : screenWidth * 0.92;
    final double cardHeight = 85;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text('My Profile', style: AppTextStyles.mainHeadline),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Responsive Profile Card with background
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(
                        initialName: widget.userName,
                        initialPhone: widget.userPhone,
                        avatarUrl: widget.userAvatarUrl,
                        // Pass other fields as needed
                      ),
                    ),
                  );
                },
                child: Container(
                  width: cardWidth,
                  height: cardHeight,
                  decoration: BoxDecoration(
                    color: kMainHeadlineColor,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/profile_bg.png',
                      ), // Optional: add a background image
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        kMainHeadlineColor.withOpacity(0.85),
                        BlendMode.srcATop,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(widget.userAvatarUrl),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.userName,
                              style: AppTextStyles.mainHeadline.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.userPhone,
                              style: AppTextStyles.instructionText.copyWith(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        size: 22,
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Settings List Section
            _SectionContainer(
              children: [
                _ProfileTile(
                  icon: Icons.notifications_none_rounded,
                  label: 'Notifications',
                  trailing: SizedBox(
                    width: 42,
                    height: 22,
                    child: Transform.scale(
                      scale: 22 / 32,
                      alignment: Alignment.center,
                      child: Switch(
                        value: notificationsOn,
                        onChanged: (val) =>
                            setState(() => notificationsOn = val),
                        activeColor: kPrimaryColor,
                        activeTrackColor: kAccentColor,
                        inactiveThumbColor: kAccentColor,
                        inactiveTrackColor: kPrimaryColor,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ),
                _ProfileTile(
                  icon: Icons.directions_bus_filled_rounded,
                  label: 'Linked Vehicle',
                  onTap: () {
                    // TODO: Navigate to linked vehicle page or fetch from backend
                  },
                ),
                _ProfileTile(
                  icon: Icons.payments_rounded,
                  label: 'Pay Monthly Fees',
                  onTap: () {
                    // TODO: Navigate to payment page or fetch from backend
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Info List Section
            _SectionContainer(
              children: [
                _ProfileTile(
                  icon: Icons.support_agent_rounded,
                  label: 'Contact Support (Help)',
                  onTap: () {
                    // TODO: Open support/contact page
                  },
                ),
                _ProfileTile(
                  icon: Icons.info_outline_rounded,
                  label: 'About',
                  onTap: () {
                    // TODO: Open about page
                  },
                ),
                _ProfileTile(
                  icon: Icons.privacy_tip_outlined,
                  label: 'Terms & Conditions and Privacy Policy',
                  onTap: () {
                    // TODO: Open terms/privacy page
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Logout
            _SectionContainer(
              children: [
                _ProfileTile(
                  icon: Icons.logout_rounded,
                  label: 'Log out',
                  iconColor: kErrorColor,
                  textColor: kErrorColor,
                  onTap: () {
                    // TODO: Implement logout logic
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      // bottomNavigationBar: const CustomNavBar(selectedIndex: 2),
    );
  }
}

// Section container for grouping tiles with background
class _SectionContainer extends StatelessWidget {
  final List<Widget> children;
  const _SectionContainer({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: kCardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(
                color: kBorderColor,
                height: 1,
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}

// Profile tile widget
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;

  const _ProfileTile({
    required this.icon,
    required this.label,
    this.trailing,
    this.onTap,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: iconColor ?? kAccentColor, size: 22),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.textFieldHeadline.copyWith(
                    color: textColor ?? kMainHeadlineColor
                  ),
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: const Color(0xFFF4A261),
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
