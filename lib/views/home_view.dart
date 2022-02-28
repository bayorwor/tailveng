import 'package:flutter/material.dart';
import 'package:tailveng/views/measurement.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ListTile(
            textColor: Colors.white,
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://t3.ftcdn.net/jpg/04/56/88/88/240_F_456888827_ChAcJFPecv4MW9srZ7ploxeHIfzU8Ypy.jpg',
                  height: 40,
                  width: 40,
                )),
            title: Text('Good Morning'),
            subtitle: Text('Esther Barahona'),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.pink,
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Measurement()));
          }),
          child: Icon(Icons.add),
        ),
        body: ListView(
          children: [
            Container(
              child: Stack(children: [
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFFC317B),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search a style ...',
                      prefixIcon: Icon(
                        Icons.search,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                )
              ]),
            ),
            Row(
              children: [
                HomeCard(
                  title: 'Number of Finished Material',
                  number: '12',
                  fcolor: Color(0xFFED91E4),
                  scolor: Color(0xDEDEDE),
                ),
                HomeCard(
                  title: 'Number of Finished Material',
                  number: '12',
                  fcolor: Color(0xFFED91E4),
                  scolor: Color(0xDEDEDE),
                ),
              ],
            ),
            Row(
              children: [
                HomeCard(
                  title: 'Number of Finished Material',
                  number: '12',
                  fcolor: Color(0xFFFC317B),
                  scolor: Color(0xDEDEDE),
                ),
              ],
            )
          ],
        ));
  }
}

class HomeCard extends StatelessWidget {
  HomeCard({
    Key? key,
    required this.fcolor,
    required this.scolor,
    required this.title,
    required this.number,
  }) : super(key: key);

  Color fcolor = Color(0xFFED91E4);
  Color scolor = Color(0xDEDEDE);
  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, top: 5),
        padding: EdgeInsets.all(20),
        height: 150,
        width: MediaQuery.of(context).size.width / 2 - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              fcolor,
              scolor,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(number,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
                Icon(
                  Icons.person,
                  size: 20,
                  color: Colors.grey,
                )
              ],
            )
          ],
        ));
  }
}
