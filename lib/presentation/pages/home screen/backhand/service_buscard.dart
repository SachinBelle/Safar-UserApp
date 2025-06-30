// import 'package:safar/presentation/pages/home screen/backhand/service_buscard.dart';

// enum HomeScreenStatus { loading, error, empty, data }

// class HomescreenPage extends StatefulWidget {
//   const HomescreenPage({super.key});

//   @override
//   State<HomescreenPage> createState() => _HomescreenPageState();
// }

// class _HomescreenPageState extends State<HomescreenPage> {
//   HomeScreenStatus status = HomeScreenStatus.loading;
//   List<BusDriver> busDrivers = [];
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     fetchBusDrivers();
//   }

//   Future<void> fetchBusDrivers() async {
//     setState(() {
//       status = HomeScreenStatus.loading;
//     });
//     try {
//       // Replace this with your backend call
//       final result = await yourBackendFetchFunction();
//       if (result.isEmpty) {
//         setState(() {
//           status = HomeScreenStatus.empty;
//         });
//       } else {
//         setState(() {
//           busDrivers = result;
//           status = HomeScreenStatus.data;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         status = HomeScreenStatus.error;
//         errorMessage = e.toString();
//       });
//     }
//   }
// }
