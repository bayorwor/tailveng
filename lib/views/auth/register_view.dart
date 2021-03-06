import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tailveng/resources/auth_methods.dart';
import 'package:tailveng/views/auth/login_view.dart';
import 'package:tailveng/views/home_view.dart';
import 'package:tailveng/widgets/toastwidget.dart';
import 'package:unicons/unicons.dart';

import '../../utils/utils.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String usertype = "designer";

  Uint8List? _image;

  bool isVisible = false;

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
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

  createAccount() {
    setState(() {
      _isLoading = true;
    });
    AuthMethods()
        .registerUser(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      usertype: usertype,
      password: _passwordController.text,
      profilePic: _image!,
    )
        .then((value) {
      if (value == "success") {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeView()),
            (route) => false);
      } else {
        setState(() {
          _isLoading = false;
        });
        showToast(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 0,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            color: Color(0xFFFC317B),
            child: SizedBox(
              height: 80,
              width: 80,
              child: Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 40,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage('assets/user.png'),
                          ),
                    Positioned(
                        bottom: -5,
                        left: 40,
                        child: IconButton(
                          onPressed: () {
                            // selectImage();
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
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.24,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                Center(
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "full name",
                            labelStyle: const TextStyle(
                              // color: Color(0xFFFC317B),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "email",
                            labelStyle: const TextStyle(
                              // color: Color(0xFFFC317B),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "phone number",
                            labelStyle: const TextStyle(
                              // color: Color(0xFFFC317B),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 102, 102, 102),
                            ),
                          ),
                          width: double.infinity,
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("Designer"),
                                leading: Radio(
                                  value: "designer",
                                  groupValue: usertype,
                                  onChanged: (value) {
                                    setState(() {
                                      usertype = value.toString();
                                    });
                                  },
                                ),
                              ),
                              ListTile(
                                title: Text("Client"),
                                leading: Radio(
                                  value: "client",
                                  groupValue: usertype,
                                  onChanged: (value) {
                                    setState(() {
                                      usertype = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: isVisible,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            suffix: isVisible
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        isVisible = false;
                                      });
                                    },
                                    child: Icon(
                                      Icons.visibility_off,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        isVisible = true;
                                      });
                                    },
                                    child: Icon(Icons.visibility)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Password",
                            labelStyle: TextStyle(
                              // color: Color(0xFFFC317B),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              createAccount();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFFC317B),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  )
                                : const Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "I am an Existing User?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginView()));
                              },
                              child: const Text(
                                "Login",
                                style: TextStyle(
                                  color: Color(0xFFFC317B),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )
                      ])),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
