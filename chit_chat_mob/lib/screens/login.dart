import 'dart:async';

import 'package:chit_chat_mob/Models/Request/Login_Request.dart';
import 'package:chit_chat_mob/Models/Response/Login_Response.dart';
import 'package:chit_chat_mob/Services/custom_http_request.dart';
import 'package:chit_chat_mob/Services/login_register_service.dart';
import 'package:chit_chat_mob/screens/dashboard_screen.dart';
import 'package:chit_chat_mob/widgets/custom_scaffold.dart';
import 'package:chit_chat_mob/widgets/load_spinner.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

// not need to call this ...............
// @override
//   void didPopNext() {
//     // Trigger connectivity check when the user navigates back to this page
//     checkConnectivity();
//     super.didPopNext();
//   }
  // Function to check connectivity and show a snackbar
  void checkConnectivity() {
    Connectivity().checkConnectivity().then(
      (result) {
        setState(() {
          connectivityResult = result;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${connectivityResult.name} Connection available"),
            backgroundColor: connectivityResult == ConnectivityResult.none
                ? Colors.red
                : Colors.green,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    userName.dispose();
    password.dispose();
  }

  bool rememberPassword = true;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color uernameColor = Colors.red;
  Color passwordColor = Colors.red;
  bool loginClicked = false;
// contollers that will hold the value of textbox field
  final userName = TextEditingController();
  final password = TextEditingController();

// this is the method that will call on the login button click.........................
  _submitFormData() async {
    // If the form is valid, display a snackbar. In the real world,
    // you'd often call a server or save the information in a database.
    if (_formKey.currentState!.validate()) {
      if (connectivityResult == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enable your internet connection')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Ceredentials'),
          duration: Durations.extralong1,
        ),
      );
      setState(() {
        loginClicked = true;
      });
      // then we will call the api
      LoginRequest loginRequest = LoginRequest(userName.text, password.text);
      LoginRegisterService loginRegisterService =
          LoginRegisterService(HttpClientRequest());
      LoginResponse loginResponse =
          await loginRegisterService.loginRequest(loginRequest);
      if (loginResponse.token == null && loginResponse.refreshToken == null) {
        Timer(const Duration(milliseconds: 1000), () {
          setState(() {
            loginClicked = false;
          });
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loginResponse.errorMessage!),
            duration: Durations.extralong4,
          ),
        );
      } else {
        Timer(const Duration(milliseconds: 500), () {
          setState(() {
            loginClicked = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (builder) => DashboardScreen(
                        message: loginResponse.token,
                      )),
              (route) => false);
        });
        // ignore: use_build_context_synchronously
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(loginResponse.errorMessage!),
        //     duration: Durations.extralong4,
        //   ),
        // );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        child: Stack(children: [
      Column(
        children: [
          const Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              )),
          Expanded(
              flex: 7,
              child: SizedBox(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(25.0, 50.0, 25.0, 20.0),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 231, 231, 231),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0))),
                  child: SingleChildScrollView(
                    child: Form(
                        key: _formKey,
                        child: Column(
                          //crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: userName,
                              autofocus: true,
                              style: TextStyle(color: uernameColor),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter Email";
                                } else if (!RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return "Please enter the valid email";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                  label: const Text("UserName"),
                                  hintText: 'Enter your userName',
                                  hintStyle:
                                      const TextStyle(color: Colors.black26),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Colors.black12),
                                      borderRadius: BorderRadius.circular(10))),
                              onChanged: (value) {
                                if (RegExp(
                                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  setState(() {
                                    uernameColor = Colors.green;
                                  });
                                } else {
                                  setState(() {
                                    uernameColor = Colors.red;
                                  });
                                }
                              },
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                                controller: password,
                                obscureText: true,
                                obscuringCharacter: "*",
                                style: TextStyle(color: passwordColor),
                                onChanged: (value) {
                                  if (RegExp(
                                          r"^(?=.*[A-Z])(?=.*[@])(?=.*[0-9]).{5,}$")
                                      .hasMatch(value)) {
                                    setState(() {
                                      passwordColor = Colors.green;
                                    });
                                  } else {
                                    setState(() {
                                      passwordColor = Colors.red;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter the password";
                                  } else if (!RegExp(
                                          r"^(?=.*[A-Z])(?=.*[@])(?=.*[0-9]).{5,}$")
                                      .hasMatch(value)) {
                                    return "Uppercase,special symbol and number and the password length is 5";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    label: const Text("Password"),
                                    hintText: "Enter your password",
                                    hintStyle: const TextStyle(
                                      color: Colors.black26,
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.black12),
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        value: rememberPassword,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            rememberPassword = value!;
                                          });
                                        },
                                        activeColor: Colors.blueAccent),
                                    const Text("Remember me",
                                        style:
                                            TextStyle(color: Colors.black45)),
                                  ],
                                ),
                                GestureDetector(
                                  child: const Text(
                                    "Forget Password?",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: _submitFormData,
                                  child: const Text('Login')),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Row(
                              children: [
                                Expanded(
                                    child: Divider(
                                  color: Colors.black26,
                                )),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: Text("Sign up with"),
                                ),
                                Expanded(
                                    child: Divider(
                                  color: Colors.black26,
                                )),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Bootstrap.google,
                                  color: Colors.red,
                                  size: 35,
                                ),
                                Icon(
                                  Bootstrap.facebook,
                                  color: Colors.blue,
                                  size: 35,
                                ),
                                Icon(
                                  Bootstrap.github,
                                  color: Colors.black,
                                  size: 35,
                                ),
                                Icon(
                                  Bootstrap.linkedin,
                                  color: Colors.blue,
                                  size: 35,
                                )
                              ],
                            ),
                            // Positioned(
                            //     top: 100,
                            //     bottom: 150,
                            //     left: 30,
                            //     right: 30,
                            //     child: ClipRect(
                            //         child: BackdropFilter(
                            //             filter: ImageFilter.blur(
                            //                 sigmaX: 7.0, sigmaY: 7.0),
                            //             child: Container(
                            //               color: Colors.grey.withOpacity(0.8),
                            //               child: const LoadSpinner(
                            //                 show: true,
                            //               ),
                            //             ))))
                          ],
                        )),
                  ),
                ),
              )),
        ],
      ),
      LoadSpinner(show: loginClicked)
    ]));
  }
}
