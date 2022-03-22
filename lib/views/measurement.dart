import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailveng/resources/cleints_methods.dart';
import 'package:tailveng/widgets/toastwidget.dart';
import 'package:unicons/unicons.dart';

import '../utils/utils.dart';

class Measurement extends StatefulWidget {
  const Measurement({Key? key}) : super(key: key);

  @override
  State<Measurement> createState() => _MeasurementState();
}

class _MeasurementState extends State<Measurement> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _styleController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _breastController = TextEditingController();
  final TextEditingController _hipsController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  Uint8List? _image;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _heightController.dispose();
    _nameController.dispose();
    _genderController.dispose();
    _styleController.dispose();
    _waistController.dispose();
    _breastController.dispose();
    _hipsController.dispose();
    _lengthController.dispose();
    _locationController.dispose();
    _phoneController.dispose();
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

//send data to server
  sendData() {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      ClientMethods()
          .addClient(
        name: _nameController.text,
        phone: _phoneController.text,
        gender: _genderController.text,
        style: _styleController.text,
        waist: _waistController.text,
        breast: _breastController.text,
        hips: _hipsController.text,
        length: _lengthController.text,
        height: _heightController.text,
        location: _locationController.text,
        image: _image!,
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
        backgroundColor: Colors.pink,
        title: const Text('Measurement'),
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
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 20,
                color: Colors.pink,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is required";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: 'Enter name client',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      const SizedBox(height: 18),
                      TextFormField(
                          controller: _phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Phone is required";
                            }
                          },
                          decoration: InputDecoration(
                              labelText: 'Phone',
                              hintText: 'Enter phone number',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: _genderController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "gender is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Gender',
                                    hintText: 'Enter your gender',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                controller: _styleController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "style is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Style',
                                    hintText: 'Enter your style',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: _waistController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "waist is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Waist',
                                    hintText: 'Enter your waist',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                controller: _breastController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "breast is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Breast',
                                    hintText: 'Enter your breast',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: _hipsController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "hips is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Hips',
                                    hintText: 'Enter your hips',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                controller: _lengthController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "length is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Skirt length',
                                    hintText: 'Enter your skirt length',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextFormField(
                                controller: _heightController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "height is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Total height',
                                    hintText: 'Enter your height',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                                controller: _locationController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "location is required";
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: 'Location',
                                    hintText: 'Enter your Location',
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      const Text("Sample of Fabric"),
                      const SizedBox(height: 18),
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
                      const SizedBox(height: 18),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
