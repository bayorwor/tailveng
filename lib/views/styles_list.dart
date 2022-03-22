import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tailveng/resources/style_methods.dart';

class StyleList extends StatelessWidget {
  const StyleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style List'),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: StyleMethods().getAllStyles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error'));
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                image: DecorationImage(
                                    image: NetworkImage(snapshot.data![index]
                                        ['style_image']))));
                      });
                },
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(snapshot.data![index]['style_image']),
                ),
                title: Text("${snapshot.data![index]['style_name']}"),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            },
          );
        },
      ),
    );
  }
}
