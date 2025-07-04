import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safar/constants/app_theme/colour_theme/colour_theme.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
// ignore: unused_import
import 'package:safar/constants/nav_bar/nav_bar.dart';

class NotificationItem {
  final String title;
  final String? subtitle;
  final DateTime date;
  final bool isImportant;

  NotificationItem({
    required this.title,
    this.subtitle,
    required this.date,
    this.isImportant = false,
  });
}

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  // Dummy notifications for UI
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: "Bus 3 reached school gate.",
      date: DateTime(2025, 6, 23),
    ),
    NotificationItem(
      title: "Bus 1, Driver Sanjay is now Online.",
      date: DateTime(2025, 6, 23),
    ),
    NotificationItem(
      title: "Route Changed Tomorrow",
      subtitle:
          "Bus no. 1 will leave 15 minutes early due to traffic in the route.",
      date: DateTime(2025, 6, 22),
      isImportant: true,
    ),
  ];

  // Group notifications by date for section headers
  Map<String, List<NotificationItem>> _groupByDate(
    List<NotificationItem> items,
  ) {
    Map<String, List<NotificationItem>> grouped = {};
    for (var item in items) {
      String key = _dateLabel(item.date);
      grouped.putIfAbsent(key, () => []).add(item);
    }
    return grouped;
  }

  static String _dateLabel(DateTime date) {
    final now = DateTime(
      2025,
      6,
      23,
    ); // For demo, set "today" as in your screenshot
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return "Today (${_formatDate(date)})";
    } else if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day - 1) {
      return "Yesterday (${_formatDate(date)})";
    } else {
      return _formatDate(date);
    }
  }

  static String _formatDate(DateTime date) {
    return "${_monthName(date.month)} ${date.day}, ${date.year}";
  }

  static String _monthName(int month) {
    const months = [
      '',
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    final grouped = _groupByDate(notifications);

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: kMainHeadlineColor,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
        title: Text('NoticeBoard', style: AppTextStyles.mainHeadline),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? _buildEmptyState(context)
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                for (final entry in grouped.entries) ...[
                  _SectionHeader(label: entry.key),
                  const SizedBox(height: 8),
                  for (final n in entry.value) ...[
                    _NotificationCard(notification: n),
                    const SizedBox(height: 12),
                  ],
                ],
              ],
            ),
      // bottomNavigationBar: const CustomNavBar(initialIndex: 0),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/notification.svg', width: 160, height: 160),
          const SizedBox(height: 24),
          Text(
            "No new notice today!",
            style: AppTextStyles.mainHeadline.copyWith(
              fontSize: 16,
              color: kInstructionTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: kBorderColor, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            label,
            style: AppTextStyles.instructionText.copyWith(
              color: kMainHeadlineColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(child: Divider(color: kBorderColor, thickness: 1)),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    if (notification.isImportant) {
      return Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
            decoration: BoxDecoration(
              color: kMainHeadlineColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  notification.title,
                  style: AppTextStyles.mainHeadline.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                if (notification.subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    notification.subtitle!,
                    style: AppTextStyles.instructionText.copyWith(
                      color: Colors.white,
                      fontSize: 13,
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  "(${NotificationPage._formatDate(notification.date)})",
                  style: AppTextStyles.instructionText.copyWith(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // "Important" tag
          Positioned(
            top: 6,
            left: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                "Important",
                style: AppTextStyles.instructionText.copyWith(
                  color: kMainHeadlineColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFFFB87A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          notification.title,
          style: AppTextStyles.mainHeadline.copyWith(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      );
    }
  }
}

