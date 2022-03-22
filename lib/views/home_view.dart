import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tailveng/resources/auth_methods.dart';
import 'package:tailveng/resources/cleints_methods.dart';
import 'package:tailveng/resources/style_methods.dart';
import 'package:tailveng/shared/style_card.dart';
import 'package:tailveng/views/add_style.dart';
import 'package:tailveng/views/auth/login_view.dart';
import 'package:tailveng/views/material_list.dart';
import 'package:tailveng/views/measurement.dart';
import 'package:tailveng/views/profile_view.dart';
import 'package:tailveng/views/styles_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  initState() {
    isUserAuthenticated();
    super.initState();
  }

  isUserAuthenticated() {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginView()),
            (route) => false);
      }
    });
  }

  //greetins logic
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning!';
    }
    if (hour < 17) {
      return 'Good Afternoon!';
    }
    return 'GOod Evening!';
  }

  @override
  Widget build(BuildContext context) {
    return _auth.currentUser == null
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Scaffold(
            appBar: AppBar(
              title: FutureBuilder<Map<String, dynamic>?>(
                  future: AuthMethods().getUserDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        textColor: Colors.white,
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              '${snapshot.data!['profile_image']}',
                              height: 40,
                              width: 40,
                            )),
                        title: Text(greeting(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                            )),
                        subtitle: Text('${snapshot.data!['name']}'),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Text('Loading...');
                    } else {
                      return const Text('Welcome to Tailveng');
                    }
                  }),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileView()));
                  },
                ),
              ],
            ),
            floatingActionButton: SpeedDial(
              icon: Icons.add,
              backgroundColor: Colors.pink,
              children: [
                SpeedDialChild(
                  child: const Icon(Icons.person),
                  label: 'Add Style',
                  backgroundColor: Colors.amberAccent,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddStyle()));
                  },
                ),
                SpeedDialChild(
                  labelBackgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: const Icon(Icons.person, color: Colors.white),
                  label: 'Add Measurement',
                  backgroundColor: Colors.green,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Measurement()));
                  },
                ),
              ],
            ),
            body: ListView(
              children: [
                Container(
                  child: Stack(children: [
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFC317B),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search a style ...',
                          prefixIcon: const Icon(
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                          stream: ClientMethods().getCompletedMaterials(),
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MaterialList(
                                            materials: "completed")));
                              },
                              child: HomeCard(
                                  title: 'Number of completed materials',
                                  number: '${snapshot.data?.docs.length}',
                                  fcolor: const Color(0xFFED91E4),
                                  scolor: const Color(0xFFDEDEDE),
                                  icon: Icons.check_circle_rounded),
                            );
                          }),
                      StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                          stream: ClientMethods().getNotCompleted(),
                          builder: (context, snapshot) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MaterialList(
                                            materials: "pending")));
                              },
                              child: HomeCard(
                                title: 'Number of Pending Material',
                                number: '${snapshot.data?.docs.length}',
                                fcolor: const Color(0xFFED91E4),
                                scolor: const Color(0xFFDEDEDE),
                                icon: Icons.pending,
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
                      stream: ClientMethods().getClients(),
                      builder: (context, snapshot) {
                        return Container(
                          width: MediaQuery.of(context).size.width - 16,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MaterialList(materials: "all")));
                            },
                            child: HomeCard(
                              title: 'Number of Customers',
                              number: '${snapshot.data?.docs.length}',
                              fcolor: const Color(0xFFFC317B),
                              scolor: const Color(0xFFDEDEDE),
                              icon: Icons.people,
                            ),
                          ),
                        );
                      }),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Styles",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const StyleList()));
                        },
                        child: const Text(
                          'View all styles',
                          style: TextStyle(
                            // fontSize: 20,
                            color: Colors.pink,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: MediaQuery.of(context).size.width,
                  child: FutureBuilder<List<DocumentSnapshot>>(
                      future: StyleMethods().getAllStyles(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return StyleCard(
                              title: snapshot.data![index]['style_name'],
                              image: snapshot.data![index]['style_image'],
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0,
                        );
                      }),
                )
              ],
            ),
          );
  }
}

class HomeCard extends StatelessWidget {
  HomeCard({
    Key? key,
    required this.fcolor,
    required this.scolor,
    required this.title,
    required this.number,
    required this.icon,
  }) : super(key: key);

  Color fcolor = const Color(0xFFED91E4);
  Color scolor = const Color(0xFFDEDEDE);
  final String title;
  final String number;
  IconData icon = Icons.account_circle;

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(20),
        height: 150,
        width: MediaQuery.of(context).size.width / 2 - 15,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                number == null
                    ? const Text("0")
                    : Text(number,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                icon != null
                    ? Icon(icon)
                    : Icon(
                        icon,
                        size: 30,
                        color: Colors.white,
                      ),
              ],
            )
          ],
        ));
  }
}
