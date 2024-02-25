import 'dart:async';
import 'dart:convert';
import 'package:chit_chat_mob/Models/Request/signup_reuqest.dart';
import 'package:chit_chat_mob/Models/Response/signup_response.dart';
import 'package:chit_chat_mob/Services/custom_http_request.dart';
import 'package:chit_chat_mob/Services/login_register_service.dart';
import 'package:chit_chat_mob/screens/login.dart';
import 'package:chit_chat_mob/widgets/custom_scaffold.dart';
import 'package:chit_chat_mob/widgets/load_spinner.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class Signup extends StatefulWidget {
  const Signup({super.key});
  //final CameraDescription? camera;
  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  //late CameraController _controller;
  //late Future<void> _initializeControllerFuture;
  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

// this method will check the internet connectivity of the mobile..............
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
    // Dispose of the controller when the widget is disposed.
    upworkEmail.dispose();
    upworkPassword.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  bool rememberPassword = true;
  ConnectivityResult connectivityResult = ConnectivityResult.none;
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color uernameColor = Colors.red;
  Color passwordColor = Colors.red;
  Color emailColor = Colors.red;
  Color phoneColor = Colors.red;
  bool loginClicked = false;
// contollers that will hold the value of textbox field
  String logo = "";
  final upworkEmail = TextEditingController();
  final upworkPassword = TextEditingController();
  final phoneNumber = TextEditingController();

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
      // here we will check the image is selected or not if not then we will say please select the image
      // then submit the form.
      if (logo == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select or capture the image')),
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
      SingUpRequest singUpRequest = SingUpRequest(
          logo: logo,
          githubUserName: upworkEmail.text,
          githubPassword: upworkPassword.text,
          number: phoneNumber.text);
      LoginRegisterService loginRegisterService =
          LoginRegisterService(HttpClientRequest());
      SingUpResponse singUpResponse =
          await loginRegisterService.singUpRequest(singUpRequest);
      if (singUpResponse.success == false) {
        Timer(const Duration(milliseconds: 1000), () {
          setState(() {
            loginClicked = false;
          });
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(singUpResponse.message!),
            duration: Durations.extralong4,
            showCloseIcon: true,
          ),
        );
      } else {
        Timer(const Duration(milliseconds: 1000), () {
          setState(() {
            loginClicked = false;
          });
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const Login()),
              (route) => false);
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(singUpResponse.message!),
            duration: Durations.extralong4,
          ),
        );
      }
    }
  }

// open the camera method...
  _openCamera() async {
    if (logo != "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Your already selected an image"),
        showCloseIcon: true,
      ));
      return;
    }
    // ScaffoldMessenger.of(context).showMaterialBanner(const MaterialBanner(
    //   content: Text("camera button is clicked"),
    //   actions: [Text("undo")],
    // ));
    // now we will open the camera
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Your image will be captured"),
        showCloseIcon: true,
      ));
      var imageData = await io.File(returnedImage.path).readAsBytes();
      logo = base64Encode(imageData);
    }
  }

// here we will open the gallery.
  _openGallery() async {
    if (logo != "") {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Your already selected an image"),
        showCloseIcon: true,
      ));
      return;
    }
    // ScaffoldMessenger.of(context).showMaterialBanner(const MaterialBanner(
    //   content: Text("camera button is clicked"),
    //   actions: [Text("undo")],
    // ));
    // now we will open the camera
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Your image will be selected"),
        showCloseIcon: true,
      ));
      var imageData = await io.File(returnedImage.path).readAsBytes();
      logo = base64Encode(imageData);
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
                  padding: const EdgeInsets.fromLTRB(25.0, 30.0, 25.0, 20.0),
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
                              "Register",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: upworkEmail,
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
                                  label: const Text("Upowrk Email"),
                                  hintText: 'Enter your upwork email',
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
                                controller: upworkPassword,
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
                                    label: const Text("Upwork Password"),
                                    hintText: "Enter your upwork password",
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
                            TextFormField(
                                controller: phoneNumber,
                                style: TextStyle(color: phoneColor),
                                onChanged: (value) {
                                  if (value.length == 10) {
                                    setState(() {
                                      phoneColor = Colors.green;
                                    });
                                  } else {
                                    setState(() {
                                      phoneColor = Colors.red;
                                    });
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter the phone number";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: InputDecoration(
                                    label: const Text("Phone Number"),
                                    hintText: "Enter your phone number",
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
                              height: 20,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 6,
                                  child: GestureDetector(
                                    onTap: _openCamera,
                                    child: const Center(
                                        child: Icon(Icons.camera_alt_rounded,
                                            color: Colors.orange, size: 50)),
                                  ),
                                ),
                                Flexible(
                                  flex: 7,
                                  child: GestureDetector(
                                    onTap: _openGallery,
                                    child: const Center(
                                        child: Icon(
                                      Icons.picture_in_picture,
                                      color: Colors.orange,
                                      size: 50,
                                      // shadows: [
                                      //   Shadow(
                                      //       color: Colors.black26,
                                      //       blurRadius: 0.5)
                                      // ],
                                    )),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: _submitFormData, //_submitFormData,
                                  child: const Text('Register')),
                            ),
                            const SizedBox(
                              height: 20,
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
                              height: 15,
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
