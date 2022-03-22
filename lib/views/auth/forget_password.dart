import 'package:flutter/material.dart';
import 'package:tailveng/resources/auth_methods.dart';
import 'package:tailveng/views/auth/login_view.dart';
import 'package:tailveng/views/auth/register_view.dart';
import 'package:tailveng/views/home_view.dart';
import 'package:tailveng/widgets/toastwidget.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  _ForgetPasswordViewState createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
  }

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    AuthMethods().forgotPassword(email: _emailController.text).then((value) => {
          if (value == "success")
            {
              setState(() {
                _isLoading = false;
              }),
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Please confirm your email"),
                      content: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 60,
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Okay"),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const LoginView()),
                            );
                          },
                        )
                      ],
                    );
                  }),
            }
          else
            {
              setState(() {
                _isLoading = false;
              }),
              showToast(value)
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
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            color: Color(0xFFFC317B),
            child: SizedBox(
              height: 80,
              width: 80,
              child: Image.asset(
                "assets/logot.png",
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height * 0.6,
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
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Email",
                            labelStyle: const TextStyle(
                              // color: Color(0xFFFC317B),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              loginUser();
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: Color(0xFFFC317B),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator.adaptive(
                                    backgroundColor: Colors.white,
                                  )
                                : const Text(
                                    "Reset Password",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Remember Password?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
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
