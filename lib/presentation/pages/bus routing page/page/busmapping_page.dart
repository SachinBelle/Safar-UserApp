import 'package:flutter/material.dart';
import 'package:safar/constants/app_theme/colour_theme/colour_theme.dart';
import 'package:safar/constants/app_theme/text_theme/text_theme.dart';
import 'package:safar/constants/app_theme/button_theme/slide_button.dart';
import '../../../../Data/global/bus_info.dart';
import '../../../../Services/bus_service.dart';
import 'package:safar/presentation/pages/change stop page/change_stop.dart';

class BusMappingPage extends StatelessWidget {
  const BusMappingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<BusInfo>(
      future: BusService().fetchBusInfo(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final bus = snapshot.data!;
        return Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            backgroundColor: kBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: kMainHeadlineColor,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Bus No: ${bus.busNumber}',
              style: AppTextStyles.mainHeadline,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: kMainHeadlineColor),
                onPressed: () {
                  // TODO: Implement refresh logic
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
                child: Text(
                  'Real-time pin for bus, refreshes after every 10 seconds.',
                  // TODO: Replace with backend-provided instruction if needed
                  style: AppTextStyles.instructionText.copyWith(fontSize: 13),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Expanded(
                child: Stack(
                  children: [
                    // TODO: Replace with real map widget
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const SizedBox.expand(),
                    ),
                    // TODO: Replace with real bus pin based on backend location
                    Center(
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: const BoxDecoration(
                          color: kMainHeadlineColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.directions_bus,
                            color: Colors.amber,
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                    // Floating action buttons (keep as is or connect to backend if needed)
                    Positioned(
                      right: 18,
                      bottom: 90,
                      child: Column(
                        children: [
                          FloatingActionButton(
                            heroTag: 'share',
                            mini: true,
                            backgroundColor: Colors.white,
                            elevation: 2,
                            onPressed: () {},
                            child: const Icon(
                              Icons.share,
                              color: kMainHeadlineColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          FloatingActionButton(
                            heroTag: 'nav',
                            mini: true,
                            backgroundColor: Colors.white,
                            elevation: 2,
                            onPressed: () {},
                            child: const Icon(
                              Icons.navigation_rounded,
                              color: Color(0xFFF4A261),
                            ),
                          ),
                          const SizedBox(height: 12),
                          FloatingActionButton(
                            heroTag: 'loc',
                            mini: true,
                            backgroundColor: Colors.white,
                            elevation: 2,
                            onPressed: () {},
                            child: const Icon(
                              Icons.my_location,
                              color: kMainHeadlineColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Info bar overlay (speed, arriving, change stop)
                    Positioned(
                      top: 24,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          width: 343,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 12,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Speed Circle
                              Container(
                                width: 80,
                                height: 80,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFF5A5A),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${bus.speed}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      const Text(
                                        'km/h',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Arriving Info (expanded)
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Arriving in ${bus.etaMinutes} min!',
                                        style: AppTextStyles.mainHeadline
                                            .copyWith(fontSize: 18),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        '${bus.distanceToStopKm} km away from your stop.',
                                        style: AppTextStyles.instructionText
                                            .copyWith(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Change Stop Circle as a button
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ChangeStopPage(
                                        currentPickup:
                                            bus.pickupLocation ??
                                            'Current Pickup Address',
                                        currentDrop:
                                            bus.dropLocation ??
                                            'Current Drop Address',
                                        recentLocations:
                                            [], // Pass recent locations if available
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF3CB371),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Change\nStop',
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.instructionText
                                          .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15,
                                            height: 1.2,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Slide to Call Driver Button overlayed at bottom
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 24,
                      child: Center(
                        child: SlideToConfirmButton(
                          text: 'Slide to Call Driver (${bus.driverName})',
                          onConfirmed: () {
                            // TODO: Implement call action using backend data
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
