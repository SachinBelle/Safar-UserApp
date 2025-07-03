import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/constants/app_theme/colour_theme/colour_theme.dart';
import 'package:safar/constants/nav_bar/nav_bar.dart';
import 'package:safar/constants/app_theme/button_theme/responsive_button.dart';
import 'package:safar/presentation/pages/bus routing page/page/busmapping_page.dart';

class BusDriver {
  final String name;
  final String id;
  final String busNo;
  final String busName;
  final String statusText;
  final bool isOnline;
  final String lastSeen;
  final String imageUrl;

  BusDriver({
    required this.name,
    required this.id,
    required this.busNo,
    required this.busName,
    required this.statusText,
    required this.isOnline,
    required this.lastSeen,
    required this.imageUrl,
  });
}

class HomescreenPage extends StatefulWidget {
  const HomescreenPage({super.key});

  @override
  State<HomescreenPage> createState() => _HomescreenPageState();
}

class _HomescreenPageState extends State<HomescreenPage> {
  // Mock data for demonstration
  List<BusDriver> getBusDrivers() {
    // Return empty list to show "no bus" UI
    // return [];

    // Return list with drivers to show cards
    return [
      BusDriver(
        name: "Mr. Sanjay Kumar",
        id: "Bus-112233",
        busNo: "MH-31-1234",
        busName: "National Institute of Technology, Suratkal.",
        statusText: "Online, Last seen 1 min ago",
        isOnline: true,
        lastSeen: "1 min ago",
        imageUrl: "https://randomuser.me/api/portraits/men/32.jpg",
      ),
      BusDriver(
        name: "Mr. Kishor Rao",
        id: "Bus-445566",
        busNo: "MH-31-4321",
        busName: "National Institute of Technology, Suratkal.",
        statusText: "Offline",
        isOnline: false,
        lastSeen: "",
        imageUrl: "https://randomuser.me/api/portraits/men/33.jpg",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final busDrivers = getBusDrivers();

    return Scaffold(
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: const CustomNavBar(initialIndex: 1),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.03,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Row: Good Morning and Refresh
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good Morning, Sachin.',
                    style: AppTextStyles.mainHeadline,
                  ),
                  Row(
                    children: [
                      Text(
                        'Refresh',
                        style: AppTextStyles.instructionText.copyWith(
                          color: const Color(0xFFF4A261),
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        Icons.refresh,
                        color: const Color(0xFFF4A261),
                        size: size.width * 0.05,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Here's an update on your bus/van.",
                style: AppTextStyles.instructionText,
              ),
              SizedBox(height: size.height * 0.04),
              // Choose Bus
              Text(
                'Choose Bus',
                style: AppTextStyles.mainHeadline.copyWith(
                  color: const Color(0xFF2C2C2C),
                ),
              ),
              SizedBox(height: size.height * 0.04),
              // Main content
              Expanded(
                child: busDrivers.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/home_screen_img.svg',
                              width: size.width * 0.7,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              'No bus/van to track.',
                              style: AppTextStyles.instructionText.copyWith(
                                color: const Color(0xFF6C757D),
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: busDrivers.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(height: size.height * 0.025),
                        itemBuilder: (context, index) {
                          final driver = busDrivers[index];
                          final bool isOffline = !driver.isOnline;

                          return Container(
                            padding: EdgeInsets.all(size.width * 0.04),
                            decoration: BoxDecoration(
                              color: isOffline
                                  ? Colors.white.withOpacity(0.85)
                                  : const Color(0xFFF5F6FA),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isOffline
                                    ? Colors.white.withOpacity(0.85)
                                    : const Color(0xFFF5F6FA),
                              ),
                            ),
                            child: Opacity(
                              opacity: isOffline ? 0.6 : 1.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Profile image
                                      Opacity(
                                        opacity: isOffline ? 0.7 : 1.0,
                                        child: CircleAvatar(
                                          radius: size.width * 0.08,
                                          backgroundImage: NetworkImage(
                                            driver.imageUrl,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: size.width * 0.04),
                                      // Name and details
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              driver.name,
                                              style: AppTextStyles.mainHeadline
                                                  .copyWith(
                                                    fontSize:
                                                        size.width * 0.045,
                                                    color: isOffline
                                                        ? Colors.black54
                                                        : null,
                                                  ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "ID: ${driver.id}",
                                                  style: AppTextStyles
                                                      .instructionText
                                                      .copyWith(
                                                        color: isOffline
                                                            ? Colors.red
                                                                  .withOpacity(
                                                                    0.7,
                                                                  )
                                                            : const Color(
                                                                0xFFF4A261,
                                                              ),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize:
                                                            size.width * 0.035,
                                                      ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4),
                                            driver.isOnline
                                                ? RichText(
                                                    text: TextSpan(
                                                      children: [
                                                        TextSpan(
                                                          text: "Online, ",
                                                          style: AppTextStyles
                                                              .instructionText
                                                              .copyWith(
                                                                color: Colors
                                                                    .green,
                                                                fontSize:
                                                                    size.width *
                                                                    0.035,
                                                              ),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "Last seen ${driver.lastSeen}",
                                                          style: AppTextStyles
                                                              .instructionText
                                                              .copyWith(
                                                                color: Colors
                                                                    .blueGrey,
                                                                fontSize:
                                                                    size.width *
                                                                    0.035,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                : Text(
                                                    "Offline",
                                                    style: AppTextStyles
                                                        .instructionText
                                                        .copyWith(
                                                          color: Colors.red
                                                              .withOpacity(0.7),
                                                          fontSize:
                                                              size.width *
                                                              0.035,
                                                        ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                      // Phone icon at the right edge
                                      CircleAvatar(
                                        radius: size.width * 0.06,
                                        backgroundColor: isOffline
                                            ? const Color(
                                                0xFFFF9800,
                                              ).withOpacity(0.15)
                                            : const Color(0xFFF4A261),
                                        child: Icon(
                                          Icons.phone_rounded,
                                          color: isOffline
                                              ? Colors.orange.withOpacity(0.5)
                                              : const Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                          size: size.width * 0.06,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Text(
                                    "Bus No: ${driver.busNo}",
                                    style: AppTextStyles.instructionText
                                        .copyWith(
                                          color: isOffline
                                              ? Colors.black38
                                              : const Color(0xFF2C2C2C),
                                          fontWeight: FontWeight.w500,
                                          fontSize: size.width * 0.037,
                                        ),
                                  ),
                                  Text(
                                    "Bus Name: ${driver.busName}",
                                    style: AppTextStyles.instructionText
                                        .copyWith(
                                          color: isOffline
                                              ? Colors.black38
                                              : const Color(0xFF2C2C2C),
                                          fontWeight: FontWeight.w500,
                                          fontSize: size.width * 0.037,
                                        ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  ResponsiveButton(
                                    text: "Track Bus",
                                    outlined: isOffline,
                                    height: 44,
                                    onPressed: driver.isOnline
                                        ? () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const BusMappingPage(),
                                              ),
                                            );
                                          }
                                        : () {},
                                  ),
                                  if (isOffline)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "We'll send you a notification once driver is online.",
                                        style: AppTextStyles.instructionText
                                            .copyWith(
                                              color: Colors.black38,
                                              fontSize: size.width * 0.032,
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
        ),
      ),
    );
  }
}
