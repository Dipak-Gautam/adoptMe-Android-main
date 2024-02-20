import 'dart:ffi';

import 'package:flutter/material.dart';
import '../../exports.dart';

class CardAnimal extends StatelessWidget {
  final String name;
  final String race;
  final String sex;
  final String old;
  final String distance;
  final Color color;
  final String link;
  final int stars;
  const CardAnimal(
      {Key? key,
      this.name = 'Nome',
      this.race = 'Raça',
      this.sex = 'Sexo',
      this.old = 'idade',
      this.distance = 'distancia',
      this.color = Colors.black,
      this.stars = 0,
      this.link = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(size.width * 0.05),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Center(
              child: SizedBox(
                height: constraints.maxHeight * 0.85,
                width: constraints.maxWidth * 0.93,
                // color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardPerfil(
                      height: constraints.maxWidth * 0.33,
                      width: constraints.maxWidth * 0.33,
                      color: color,
                      link: link,
                    ),
                    CardTexts(
                      widthA: constraints.maxWidth * 0.4,
                      // widthB: constraints.maxWidth * 0.45,
                      name: name,
                      race: race,
                      sex: sex,
                      old: old,
                      distance: distance,
                    ),
                    CardIcon(
                      stars: stars,
                      width: constraints.maxWidth * 0.13,
                      height: constraints.maxHeight * 0.4,
                      sizeIcon: constraints.maxHeight * 0.24,
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
        const SizedBox(
          height: 10,
        )
        // Container(
        //   height: size.height * 0.03,
        // ),
      ],
    );
  }
}
