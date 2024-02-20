// ignore_for_file: prefer_const_constructors

import '../../exports.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 700),
          builder: (context, value, _) {
            return Column(
              children: [
                Opacity(
                  opacity: value,
                  child: SizedBox(
                      width: double.infinity,
                      height: Layouts.getSize(context).height * 0.65,
                      child: Image.asset(
                        'assets/landing/starter_header.png',
                        fit: BoxFit.cover,
                      )),
                ),
                const SizedBox(
                  height: 35,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 70),
                  child: Text('Re-Home and\nAdopt a Pet',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Styles.blackColor,
                        fontSize: value * 26,
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ).apply(fontWeightDelta: 2)),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Adopt me, we both need the love',
                  textScaleFactor: value,
                  style: TextStyle(color: Styles.highlightColor),
                ),
                const SizedBox(
                  height: 50,
                ),
                Opacity(
                  opacity: value,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                    ),
                    child: const Text('Get Started',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                )
              ],
            );
          }),
    );
  }
}
