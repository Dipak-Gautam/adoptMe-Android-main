import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardTexts extends StatelessWidget {
  final double? widthA;
  final double? widthB;
  ////
  final String name;
  final String race;
  final String sex;
  final String old;
  final String distance;
  const CardTexts(
      {Key? key,
      this.widthA,
      this.name = 'Nome',
      this.race = 'Raça',
      this.sex = 'Sexo',
      this.old = 'idade',
      this.distance = 'distancia',
      this.widthB})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthA,
      // color: Colors.amber,
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // color: Colors.blue,
              height: constraints.maxHeight * 0.63,
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      race,
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    Text(
                      '$sex, $old',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                );
              }),
            ),
            Container(
              height: constraints.maxHeight * 0.25,
              // color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_sharp,
                    color: Colors.red,
                  ),
                  Text(
                    distance,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
/////////////////////

    // Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               name,
    //               style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
    //             ),
    //             Text(
    //               race,
    //               style: TextStyle(color: Colors.grey[800]),
    //             ),
    //             Text(
    //               '$sex, $old',
    //               style: TextStyle(color: Colors.grey[500]),
    //             ),
    //           ],
    //         ),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             const Icon(
    //               Icons.location_on_sharp,
    //               color: Colors.red,
    //             ),
    //             Text(
    //               distance,
    //               style: TextStyle(color: Colors.grey[600]),
    //             ),
    //           ],
    //         ),

    ////////////
    // Column(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Container(
    //       width: widthA,
    //       color: Colors.amber,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(name),
    //               Text(race),
    //               Text('$sex, $old'),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //     Container(
    //       width: widthB,
    //       color: Colors.red,
    //       child: Text(distance),
    //     )
    //   ],
    // );
  }
}
