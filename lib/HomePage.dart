import 'package:flutter/material.dart';
import 'package:gather_mvp/routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          for (int i = 0; i < route.keys.length; i++)
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, route.keys.toList()[i]);
                },
                child: Text(route.keys.toList()[i]),
              ),
            )
        ]),
      ),
    );
  }
}
