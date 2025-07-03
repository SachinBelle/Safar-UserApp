import '../Data/global/bus_info.dart';

class BusService {
  // Replace with your actual backend call
  Future<BusInfo> fetchBusInfo() async {
    // TODO: Implement real backend call
    await Future.delayed(Duration(seconds:1));
    return BusInfo(
      busNumber: 'MH-31-1234',
      driverName: 'Sanjay',
      speed: 35,
      etaMinutes: 8,
      distanceToStopKm: 1.0,
    );
  }
}
