import 'package:flutter/material.dart';
import '../../exports.dart';

class ListViewAnimals extends StatelessWidget {
  const ListViewAnimals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        CardAnimal(
          name: 'Sparky',
          race: 'Golden Retriver',
          sex: 'Female',
          old: '8 months old',
          distance: '2.5 Kms away',
          color: Colors.yellow.shade300,
          link: 'assets/landing/starter_header.png',
        ),
        CardAnimal(
          name: 'Charlie',
          race: 'Boston Tirrier',
          sex: 'Male',
          old: '1.5 years old',
          distance: '2.6 Kms away',
          color: Colors.teal.shade200,
          link: 'assets/landing/starter_header.png',
        ),
        CardAnimal(
          name: 'Max',
          race: 'Siberian Husky',
          sex: 'Male',
          old: '1 year old',
          distance: '2.9 Kms away',
          color: Colors.blue.shade200,
          link: 'assets/landing/starter_header.png',
        ),
        CardAnimal(
          name: 'Daisy',
          race: 'Maltese',
          sex: 'Female',
          old: '7 months old',
          distance: '3.1s Kms away',
          color: Colors.deepOrange.shade200,
          link: 'assets/landing/starter_header.png',
        ),
        CardAnimal(
          name: 'Zoe',
          race: 'Jack Russell Terrier',
          sex: 'Female',
          old: '8 months old',
          distance: '2.5 Kms away',
          color: Colors.green.shade200,
          link: 'assets/landing/starter_header.png',
        ),
        CardAnimal(
          name: 'Zoe',
          race: 'Jack Russell Terrier',
          sex: 'Female',
          old: '8 months old',
          distance: '2.5 Kms away',
          color: Colors.green.shade200,
          link: 'assets/landing/starter_header.png',
        ),
        // ListView(
        //   children: [Container()],
        // ),
      ],
    );
  }
}
