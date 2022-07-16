// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class CountBar extends StatefulWidget {
//   const CountBar({Key? key}) : super(key: key);

//   @override
//   State<CountBar> createState() => _CountBarState();
// }

// class _CountBarState extends State<CountBar> {
//   int num = 1;
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         RawMaterialButton(
//           onPressed: () {
//             if (num < 99) {
//               setState(() {
//                 num++;
//               });
//             }
//           },
//           elevation: 2.0,
//           fillColor: Colors.orange,
//           child: Icon(
//             Icons.add,
//             size: 30.0,
//             color: Colors.white,
//           ),
//           padding: EdgeInsets.all(5.0),
//           shape: CircleBorder(),
//         ),
//         Text(num.toString()),
//         RawMaterialButton(
//           onPressed: () {
//             if (num > 1) {
//               setState(() {
//                 num--;
//               });
//             }
//           },
//           elevation: 2.0,
//           fillColor: Colors.orange,
//           child: Icon(
//             Icons.remove,
//             size: 30.0,
//             color: Colors.white,
//           ),
//           padding: EdgeInsets.all(5.0),
//           shape: CircleBorder(),
//         )
//       ],
//     );
//   }
// }
