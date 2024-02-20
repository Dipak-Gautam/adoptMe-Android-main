import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardPerfil extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final String link;
  const CardPerfil(
      {Key? key,
      this.height,
      this.width,
      this.color = Colors.black,
      this.link = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: CachedNetworkImage(
        imageUrl: link,
        fit: BoxFit.cover,
      ),
    );
  }
}
