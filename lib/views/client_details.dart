import 'package:flutter/material.dart';

class ClientDetails extends StatelessWidget {
  const ClientDetails({Key? key, required this.client}) : super(key: key);
  final client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${client['name']}'),
        ),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Phone Number'),
                trailing: Text('${client['phone']}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Location'),
                trailing: Text('${client['location']}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('height'),
                trailing: Text('${client['height']}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('length'),
                trailing: Text('${client['length']}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('hips'),
                trailing: Text('${client['hips']}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('waist'),
                trailing: Text('${client['waist']}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('style'),
                trailing: Text('${client['style']}'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('gender'),
                trailing: Text('${client['gender']}'),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: client["image"] != null
                    ? Image(
                        image: NetworkImage("${client['image']}"),
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : const CircularProgressIndicator.adaptive()),
            const SizedBox(height: 10),
          ],
        ));
  }
}
