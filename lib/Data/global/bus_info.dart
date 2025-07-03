class BusInfo {
  final String busNumber;
  final String driverName;
  final int speed;
  final int etaMinutes;
  final double distanceToStopKm;
  
  BusInfo({
    required this.busNumber,
    required this.driverName,
    required this.speed,
    required this.etaMinutes,
    required this.distanceToStopKm,
  });

  get pickupLocation => null;

  get dropLocation => null;
}
