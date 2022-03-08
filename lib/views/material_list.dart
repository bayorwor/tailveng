import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tailveng/resources/cleints_methods.dart';

class MaterialList extends StatefulWidget {
  MaterialList({Key? key}) : super(key: key);

  @override
  State<MaterialList> createState() => _MaterialListState();
}

class _MaterialListState extends State<MaterialList> {
  DoNothingAction _doNothingAction = DoNothingAction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material List'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
          stream: ClientMethods().getClients(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    snapshot.data == null) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data == null) {
                  return const Center(child: Text('No data available'));
                }

                return Slidable(
                  // Specify a key if the Slidable is dismissible.
                  key: const ValueKey(0),

                  // The end action pane is the one at the right or the bottom side.
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.
                        // flex: 2,
                        onPressed: (context) {
                          print('pressed');
                        },
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.check_circle,
                        label: 'Done',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          print('pressed');
                        },
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remove',
                      ),
                    ],
                  ),

                  // The child of the Slidable is what the user sees when the
                  // component is not dragged.
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('${snapshot.data!.docs[index]['name']}'),
                        subtitle:
                            Text('${snapshot.data!.docs[index]['phone']}'),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            'https://picsum.photos/250?image=9',
                            width: 60.0,
                            height: 120.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
            );
          }),
    );
  }
}
