// import 'package:flutter/material.dart';

// class CardIcon extends StatefulWidget {
//   final double? height;
//   final double? width;
//   final double? sizeIcon;
//   final int stars;
//   const CardIcon(
//       {Key? key, this.width, this.height, this.sizeIcon, required this.stars})
//       : super(key: key);

//   @override
//   State<CardIcon> createState() => _CardIconState();
// }

// bool active = false;

// class _CardIconState extends State<CardIcon> {
//   late int star;
//    void initState() {
//     super.initState();
//     star = widget.stars;
//   }
//   @override
//   Widget build(BuildContext context) {
//    // int star = widget.stars;
//     return Align(
//       alignment: Alignment.topRight,
//       child: Container(
//         width: widget.width,
//         height: 65,
//         // color: Colors.green,
//         child: Align(
//           alignment: Alignment.topRight,
//           child: Column(
//             children: [
//               IconButton(
//                 icon: Icon(
//                   active == true
//                       ? Icons.favorite_rounded
//                       : Icons.favorite_border_rounded,
//                   color: active == true ? Colors.red : Colors.grey[500],
//                   size: widget.sizeIcon,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     active = true;
//                     star = star + 1;
//                   });
//                 },
//               ),
//               Text(
//                 star.toString(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CardIcon extends StatefulWidget {
  final double? height;
  final double? width;
  final double? sizeIcon;
  final int stars;
  const CardIcon(
      {Key? key, this.width, this.height, this.sizeIcon, required this.stars})
      : super(key: key);

  @override
  State<CardIcon> createState() => _CardIconState();
}

class _CardIconState extends State<CardIcon> {
  late int star;
  late bool active;

  @override
  void initState() {
    super.initState();
    active = true;
    star = widget.stars;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: widget.width,
        height: 65,
        // color: Colors.green,
        child: Align(
          alignment: Alignment.topRight,
          child: Column(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              Text(
                star.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
