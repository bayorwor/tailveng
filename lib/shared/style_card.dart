import 'package:flutter/material.dart';

class StyleCard extends StatelessWidget {
  const StyleCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 130,
      child: Card(
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image(
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                  image: NetworkImage('https://picsum.photos/250?image=9'))),
          Text('Some text'),
        ]),
      ),
    );
  }
}
