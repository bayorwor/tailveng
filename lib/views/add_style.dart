import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailveng/resources/style_methods.dart';
import 'package:tailveng/widgets/toastwidget.dart';
import 'package:unicons/unicons.dart';

import '../utils/utils.dart';

class AddStyle extends StatefulWidget {
  AddStyle({Key? key}) : super(key: key);

  @override
  State<AddStyle> createState() => _AddStyleState();
}

class _AddStyleState extends State<AddStyle> {
  final TextEditingController _styleController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _styleController.dispose();
  }

  // selecting image from gallery
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

// selecting image from camera
  void selectCamera() async {
    Uint8List im = await pickImage(ImageSource.camera);
    setState(() {
      _image = im;
    });
  }

  //sendata to server
  void sendData() async {
    setState(() {
      _isLoading = true;
    });
    if (formKey.currentState!.validate()) {
      StyleMethods()
          .addStyle(
        styleName: _styleController.text,
        styleImage: _image!,
      )
          .then((value) {
        if (value == "success") {
          setState(() {
            _isLoading = false;
          });
          showToast("Data sent successfully", color: Colors.green);
          Navigator.pop(context);
        } else {
          setState(() {
            _isLoading = false;
          });
          showToast(
            "Data not sent",
          );
        }
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      showToast(
        "Data not sent",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Style'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : TextButton.icon(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                      icon: const Icon(UniconsLine.save),
                      label: const Text('Save'),
                      onPressed: () {
                        sendData();
                      },
                    ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          controller: _styleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "style name is required";
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Style Name',
                            hintText: 'Enter style name',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                          )),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Select Image from",
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          selectCamera();
                                        },
                                        icon: const Icon(
                                          UniconsLine.camera,
                                          size: 50,
                                          color: Colors.black,
                                        ),
                                        label: const Text("camera"),
                                      ),
                                      const Divider(),
                                      TextButton.icon(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          selectImage();
                                        },
                                        icon: const Icon(
                                          UniconsLine.image,
                                          size: 50,
                                        ),
                                        label: const Text("gallery"),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: _image == null
                            ? Image.asset('assets/placeholder.jpg')
                            : Image.memory(_image!),
                      ),
                    ],
                  )),
            )
          ],
        ));
  }
}
