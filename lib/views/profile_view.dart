import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tailveng/resources/auth_methods.dart';

class ProfileView extends StatelessWidget {
  ProfileView({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile '),
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
          future: AuthMethods().getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(snapshot.data!['profile_image']),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  ListTile(
                    trailing: const Icon(Icons.work),
                    title: Text("${snapshot.data!['usertype']}"),
                  ),
                  const Divider(),
                  ListTile(
                    trailing: const Icon(Icons.person),
                    title: Text("${snapshot.data!['name']}"),
                  ),
                  const Divider(),
                  ListTile(
                    trailing: const Icon(Icons.email),
                    title: Text("${snapshot.data!['email']}"),
                  ),
                  const Divider(),
                  ListTile(
                    trailing: const Icon(Icons.phone),
                    title: Text("${snapshot.data!['phone']}"),
                  ),
                  ListTile(
                    onTap: () {
                      _auth.signOut();
                    },
                    iconColor: Colors.red,
                    leading: const Icon(Icons.logout_rounded),
                    title: const Text("Logout",
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text("OOps something went wrong"));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
