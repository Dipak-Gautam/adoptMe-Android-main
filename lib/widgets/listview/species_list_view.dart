import 'package:flutter/material.dart';
import '../../exports.dart';

class ListViewCardsSpecies extends StatefulWidget {
  ListViewCardsSpecies({Key? key}) : super(key: key);

  @override
  State<ListViewCardsSpecies> createState() => _ListViewCardsSpeciesState();
}

class _ListViewCardsSpeciesState extends State<ListViewCardsSpecies> {
  final List listSpecies = [
    ListViewSpeciesModel('Dogs', 'assets/icons/dog_icon.png'),
    ListViewSpeciesModel('Cats', 'assets/icons/cat_icon.png'),
    ListViewSpeciesModel('Birds', 'assets/icons/bird_icon.png'),
    ListViewSpeciesModel('Hourses', 'assets/icons/horse_icon.png'),
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final ListViewSpeciesModel item = listSpecies[index];
        return SpeciesButton(
          species: item.species,
          link: item.link,
          isSelected: index == selectedIndex,
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
        );
      },
      separatorBuilder: (context, index) {
        return LayoutBuilder(builder: (context, constraints) {
          return const SizedBox(
            width: 5,
          );
        });
      },
      itemCount: listSpecies.length,
    );
  }
}
