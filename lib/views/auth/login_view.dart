import 'package:flutter/material.dart';
import 'package:tailveng/resources/auth_methods.dart';
import 'package:tailveng/views/auth/register_view.dart';
import 'package:tailveng/views/home_view.dart';
import 'package:tailveng/widgets/toastwidget.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  loginUser() async {
    setState(() {
      _isLoading = true;
    });
    AuthMethods()
        .loginUser(
            email: _emailController.text, password: _passwordController.text)
        .then((value) => {
              if (value == "success")
                {
                  setState(() {
                    _isLoading = false;
                  }),
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => HomeView()))
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
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Password",
                            labelStyle: const TextStyle(
                              // color: Color(0xFFFC317B),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Color(0xFFFC317B),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
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
                                    "Login",
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
                              "Don't have an account?",
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
                                        builder: (context) => RegisterView()));
                              },
                              child: const Text(
                                "Sign Up",
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
