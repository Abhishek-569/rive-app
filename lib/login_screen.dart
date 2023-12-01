import 'package:flutter/material.dart';
import 'package:ml_kit_face_dtector/app/modules/face_detector_gallery/views/face_detector_gallery_view.dart';
import 'package:ml_kit_face_dtector/speech.dart';
import 'package:rive/rive.dart';
import 'package:get/get.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  ///Login details
  String emailCred = "abhi@gmail.com";
  String passwordCred = "123456";

  /// input form controller
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailCtr = TextEditingController();

  FocusNode passwordFocusNode = FocusNode();
  TextEditingController passwordCtr = TextEditingController();

  /// rive controller and input values
  StateMachineController? controller;

  SMIInput<bool>? check;
  SMIInput<double>? look;
  SMIInput<bool>? success;
  SMIInput<bool>? fail;

  bool isLoading1 = false;
  bool isLoading2 = false;

  bool isError = false;
  void facePresent(bool Present) async {
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );
    if (Present) {
      success?.change(true);
    } else {
      fail?.change(true);
    }
  }

  @override
  void initState() {
    emailFocusNode.addListener(emailFocus);
    passwordFocusNode.addListener(passwordFocus);
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener(emailFocus);
    passwordFocusNode.removeListener(passwordFocus);
    super.dispose();
  }

  void emailFocus() {
    check?.change(emailFocusNode.hasFocus);
  }

  void passwordFocus() {
    check?.change(passwordFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xffB581EB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(
              height: 80,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Welcome Back!\n How may I help you today?",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: RiveAnimation.asset(
                "assets/login_screen.riv",
                fit: BoxFit.fitHeight,
                stateMachines: const ["Login State Machine"],
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    "Login State Machine",
                  );
                  if (controller == null) return;
                  artboard.addController(controller!);
                  check = controller?.findInput("check");
                  look = controller?.findInput("look");
                  success = controller?.findInput("success");
                  fail = controller?.findInput("fail");
                },
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffB581EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () async {
                            facedetector();
                          },
                          child: isLoading1
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Face Detector",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                        )),
                    const SizedBox(height: 16),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 64,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffB581EB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () async {
                            voiceRecog();
                          },
                          child: isLoading2
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Voice Recognition",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                        )),
                  ],
                ))
          ]),
        ),
      ),
    );
  }

  void voiceRecog() async {
    final email = emailCtr.text;
    final password = passwordCtr.text;

    setState(() {
      isLoading2 = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );

    // if (email == emailCred && password == passwordCred) {
    success?.change(true);
    setState(() {
      isError = false;
    });
    if (context.mounted) {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MySpeechApp()));
      });
    }
    // } else {
    // setState(() {
    //   isError = true;
    // });
    //   fail?.change(true);
    // }
    setState(() {
      isLoading2 = false;
    });
  }

  void facedetector() async {
    final email = emailCtr.text;
    final password = passwordCtr.text;

    setState(() {
      isLoading1 = true;
    });
    await Future.delayed(
      const Duration(milliseconds: 2000),
    );

    // if (email == emailCred && password == passwordCred) {
    success?.change(true);
    setState(() {
      isError = false;
    });
    if (context.mounted) {
      await Future.delayed(const Duration(seconds: 2), () {
        Get.to(() => FaceDetectorGalleryView());
      });
    }
    // } else {
    // setState(() {
    //   isError = true;
    // });
    //   fail?.change(true);
    // }
    setState(() {
      isLoading1 = false;
    });
  }
}
