// import 'package:flutter/material.dart';
// import 'package:fview/components/infomodal.dart';
// import 'package:fview/screens/Infopage.dart';
// import 'package:fview/utils/utils.dart';
// import 'package:hive/hive.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// class FavCard extends StatefulWidget {
//   const FavCard(
//       {super.key,
//       required this.decoded,
//       required this.FavBox,
//       required this.FavBoxLength,
//       required this.updateFavBoxLength}); // Add this line

//   final decoded;
//   final Box FavBox;
//   final int FavBoxLength;
//   final Function updateFavBoxLength; // Add this line

//   @override
//   State<FavCard> createState() => _FavCardState();
// }

// class _FavCardState extends State<FavCard> {
//   @override
//   Widget build(BuildContext context) {
//     print(widget.decoded);
//     return Material(
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onLongPress: () {
//           showCupertinoModalBottomSheet(
//             context: context,
//             builder: (context) => InfoModal(
//               id: widget.decoded["id"],
//               controller: ModalScrollController.of(context),
//             ),
//           );
//         },
//         onTap: () {
//           Navigator.push(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (context, animation, secondaryAnimation) => InfoPage(
//                 id: widget.decoded["id"],
//               ),
//               transitionsBuilder:
//                   (context, animation, secondaryAnimation, child) {
//                 const begin = Offset(1.0, 0.0);
//                 const end = Offset.zero;
//                 const curve = Curves.easeInOut;

//                 var tween = Tween(begin: begin, end: end)
//                     .chain(CurveTween(curve: curve));

//                 return SlideTransition(
//                   position: animation.drive(tween),
//                   child: child,
//                 );
//               },
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               ...addGaps([
//                 Flexible(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(10),
//                     child: Image.network(
//                       widget.decoded["image"],
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: Text(
//                     widget.decoded["title"],
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                   Material(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(10),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(10),
//                       onTap: () {
//                         showAdaptiveDialog(
//                             context: context,
//                             builder: (_) {
//                               return Container(
//                                 child: Center(
//                                   child: Container(
//                                     padding: EdgeInsets.all(20),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.grey.shade800,
//                                     ),
//                                     child: IntrinsicHeight(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           ...addGaps([
//                                             Text(
//                                                 "Are You Sure you want to delete "),
//                                             Container(
//                                               width: 300,
//                                               color: Colors.amberAccent,
//                                               padding: EdgeInsets.all(3),
//                                               child: Align(
//                                                 alignment: Alignment.center,
//                                                 child: Text(
//                                                   widget.decoded["title"],
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   maxLines: 1,
//                                                   style: TextStyle(
//                                                       color:
//                                                           const Color.fromARGB(
//                                                               255, 68, 61, 39)),
//                                                 ),
//                                               ),
//                                             ),
//                                             IntrinsicWidth(
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(4.0),
//                                                 child: Row(
//                                                   children: [
//                                                     ...addGapsHorizontal([
//                                                       ElevatedButton(
//                                                         onPressed: () async {
//                                                           await widget.FavBox
//                                                               .delete(widget
//                                                                       .decoded[
//                                                                   "id"]);
//                                                           widget.updateFavBoxLength(
//                                                               widget
//                                                                   .FavBox
//                                                                   .values
//                                                                   .length); // Update using callback
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: Text("yes"),
//                                                       ),
//                                                       ElevatedButton(
//                                                         onPressed: () {
//                                                           Navigator.pop(
//                                                               context);
//                                                         },
//                                                         child: Text("no"),
//                                                       )
//                                                     ], 10)
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ], 4)
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             });
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(6),
//                         child: Icon(
//                           Icons.delete_rounded,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ])
//               ], 4)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive/hive.dart';

class FavCard extends HookWidget {
  const FavCard(
      {super.key,
      required this.decoded,
      required this.FavBox,
      required this.FavBoxLength,
      required this.updateFavBoxLength}); // Add this line

  final decoded;
  final Box FavBox;
  final int FavBoxLength;
  final Function updateFavBoxLength;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
