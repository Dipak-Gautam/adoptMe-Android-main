import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SpeciesButton extends StatefulWidget {
  final String link;
  final String species;
  final bool isSelected;
  final void Function()? onTap;
  const SpeciesButton({
    Key? key,
    this.link = '',
    this.species = 'Especie',
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<SpeciesButton> createState() => _SpeciesButtonState();
}

class _SpeciesButtonState extends State<SpeciesButton> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          width: size.width * 0.25,
          decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xff3a57e8) : Colors.white,
            borderRadius: BorderRadius.circular(size.width * 0.065),
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: constraints.maxWidth * 0.23,
                  width: constraints.maxWidth * 0.23,
                  child: Image.asset(
                    widget.link,
                    color: widget.isSelected ? Colors.white : Colors.grey[500],
                  ),
                ),
                Container(
                  height: constraints.maxHeight * 1,
                  width: constraints.maxWidth * 0.35,
                  child: Center(
                      child: FittedBox(
                    child: Text(
                      widget.species,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: constraints.maxWidth * 0.2,
                          color: widget.isSelected
                              ? Colors.white
                              : Colors.grey[800]),
                    ),
                  )),
                ),
              ],
            );
          })),
    );
  }
}
