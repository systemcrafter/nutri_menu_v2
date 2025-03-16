import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: <Widget>[
              Container(
                height: 125,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(),
                ),
              ),
              SizedBox(width: 26),
              Column(
                children: <Widget>[
                  Text('Lasagna'),
                  Text('Edwin M'),
                  Container(
                    height: 2,
                    width: 75,
                    color: Colors.orange,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
