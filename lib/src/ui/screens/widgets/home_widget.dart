// import 'package:flutter/material.dart';

// class HomeWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15),
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.all(20),
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height / 4,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(20),
//               gradient: const LinearGradient(
//                 colors: [Colors.green, Colors.yellow, Colors.blue],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(rate.title.toString()),
//                     Text(" CB ${rate.price.toString()} so`m"),
//                   ],
//                 ),
//                 Text("Sell ${rate.sell.toString()}"),
//                 Text("Buy ${rate.buy.toString()}")
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
