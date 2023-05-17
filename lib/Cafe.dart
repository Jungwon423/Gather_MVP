import 'package:flutter/material.dart';

class Cafe extends StatelessWidget {
  const Cafe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [Image.asset('assets/images/카페.png')],),
    );
  }
}
