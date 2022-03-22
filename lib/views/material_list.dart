import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:tailveng/resources/cleints_methods.dart';
import 'package:tailveng/views/client_details.dart';
import 'package:tailveng/widgets/toastwidget.dart';

class MaterialList extends StatefulWidget {
  MaterialList({
    Key? key,
    required this.materials,
  }) : super(key: key);

  final String materials;

  @override
  State<MaterialList> createState() => _MaterialListState();
}

class _MaterialListState extends State<MaterialList> {
  DoNothingAction _doNothingAction = DoNothingAction();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.materials} List'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>?>>(
          stream: widget.materials == "completed"
              ? ClientMethods().getCompletedMaterials()
              : widget.materials == "pending"
                  ? ClientMethods().getNotCompleted()
                  : ClientMethods().getClients(),
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
                      widget.materials != "completed"
                          ? SlidableAction(
                              // An action can be bigger than the others.
                              // flex: 2,
                              onPressed: (context) {
                                if (widget.materials == "completed") {
                                  return;
                                } else if (widget.materials == "pending") {
                                  String value = ClientMethods().updateToDone(
                                      snapshot.data!.docs[index].id);

                                  if (value == "success") {
                                    showToast("Updated successfully",
                                        color: Colors.green);
                                  } else {
                                    showToast("OOPS!! something went wrong",
                                        color: Colors.red);
                                  }
                                } else {
                                  ClientMethods().updateToDone(
                                      snapshot.data!.docs[index].id);
                                }
                              },
                              backgroundColor: Color(0xFF7BC043),
                              foregroundColor: Colors.white,
                              icon: Icons.check_circle,
                              label: 'Done',
                            )
                          : Text(""),
                      SlidableAction(
                        onPressed: (context) {
                          String value = ClientMethods()
                              .deleteOne(snapshot.data!.docs[index].id);

                          if (value == "success") {
                            showToast("Deleted successfully",
                                color: Colors.green);
                          } else {
                            showToast("OOPS!! something went wrong",
                                color: Colors.red);
                          }
                        },
                        backgroundColor: Color(0xFF0F0F0F),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Remove',
                      ),
                      SlidableAction(
                        onPressed: (context) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ClientDetails(
                                      client: snapshot.data!.docs[index])));
                        },
                        backgroundColor: Color(0xFF0392CF),
                        foregroundColor: Colors.white,
                        icon: Icons.visibility,
                        label: 'View',
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
                            child: snapshot.data!.docs[index]["image"] != null
                                ? Image.network(
                                    '${snapshot.data!.docs[index]['image']}',
                                    width: 60.0,
                                    height: 120.0,
                                    fit: BoxFit.cover,
                                  )
                                : const CircularProgressIndicator.adaptive()),
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
