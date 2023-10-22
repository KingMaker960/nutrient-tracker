import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manipal/LoginScreen.dart';
import 'package:manipal/constants.dart';
import 'package:manipal/widgets/customnavigation.dart';
import 'package:manipal/widgets/sqlqueries.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OtpLogin extends StatefulWidget {
  final String name;
  final String age;
  final String number;
  final String rollnumber;
  final String password;
  String otp;
  OtpLogin(
      {Key? key,
      required this.name,
      required this.age,
      required this.number,
      required this.rollnumber,
      required this.password,
      required this.otp})
      : super(key: key);

  @override
  State<OtpLogin> createState() => _OtpLoginState();
}

class _OtpLoginState extends State<OtpLogin> {
  Icon icon = const Icon(
    FontAwesomeIcons.check,
    size: 43,
    color: Colors.white,
  );
  Color color = Color_Green;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final firstController = TextEditingController();
  final secondController = TextEditingController();
  final thirdController = TextEditingController();
  final fourthController = TextEditingController();
  final fifthController = TextEditingController();
  final sixthController = TextEditingController();
  final snackbar = const SnackBar(
    content: Text(
      "Registration Successful !",
      style: TextStyle(fontFamily: "WorkSans", color: Colors.white),
    ),
    backgroundColor: Color_Green,
  );
  double _width = double.maxFinite;
  double _height = 60;
  bool _success = false;
  bool _pressed = false;
  bool isTimer = true;

  //resending timer running
  late Timer _timer;
  int _start = 60;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isTimer = false;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    firstController.dispose();
    secondController.dispose();
    thirdController.dispose();
    fourthController.dispose();
    fifthController.dispose();
    sixthController.dispose();
  }

//timer finished
//phoneauthenticate
  void verifyCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        await createUser(widget.name, widget.age, widget.number,
            widget.rollnumber, widget.password);

        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('visited', 'true');
        setState(() {
          _success = true;

          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        });
        await Future.delayed(const Duration(milliseconds: 2200));
        if (!mounted) return;
        Navigator.pop(context);
        Navigator.pushReplacement(
            context, CustomPageRoute(child: const LoginScreen()));
      }
    } on FirebaseAuthException {
      setState(() {
        _success = true;
        color = Colors.red;
        icon = const Icon(
          FontAwesomeIcons.xmark,
          size: 43,
          color: Colors.white,
        );
      });
      showAlertDialog(
          context,
          "Failed To Authenticate",
          "Wrong OTP",
          "The Code You Entered Is Wrong. Please Enter Correct OTP to Complete Registration.",
          "failed.json",
          true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _success = false;
        _pressed = false;
        _width = double.maxFinite;
      });
    }
  }

  bool error = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color_Blue,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(top: 15.0, bottom: 25.0),
          margin: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _pressed
                        ? () {}
                        : () {
                            print(widget.name);
                          },
                    child: const Icon(
                      FontAwesomeIcons.arrowLeftLong,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 125,
                  ),
                  const Text(
                    "OTP",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: "WorkSans",
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )
                ],
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  Image.asset("assets/images/otp.png"),
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    "Verification Code",
                    style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 22,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please Type The Verification Code Sent To +977${widget.number}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 16,
                        color: Colors.white),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextField(
                            enabled: _pressed ? false : true,
                            controller: firstController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  error = true;
                                  // FocusScope.of(context).previousFocus();
                                });
                              } else if (value.length == 1) {
                                setState(() {
                                  error = false;
                                });
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSans",
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextField(
                            enabled: _pressed ? false : true,
                            controller: secondController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  error = true;
                                  FocusScope.of(context).previousFocus();
                                });
                              } else if (value.length == 1) {
                                setState(() {
                                  error = false;
                                });
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSans",
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextField(
                            enabled: _pressed ? false : true,
                            controller: thirdController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  error = true;
                                  FocusScope.of(context).previousFocus();
                                });
                              } else if (value.length == 1) {
                                setState(() {
                                  error = false;
                                });
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSans",
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            enabled: _pressed ? false : true,
                            controller: fourthController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  error = true;
                                  FocusScope.of(context).previousFocus();
                                });
                              } else if (value.length == 1) {
                                setState(() {
                                  error = false;
                                });
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSans",
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextField(
                            enabled: _pressed ? false : true,
                            controller: fifthController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  error = true;
                                  FocusScope.of(context).previousFocus();
                                });
                              } else if (value.length == 1) {
                                setState(() {
                                  error = false;
                                });
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSans",
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: TextField(
                            enabled: _pressed ? false : true,
                            controller: sixthController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  error = true;
                                  FocusScope.of(context).previousFocus();
                                });
                              } else if (value.length == 1) {
                                setState(() {
                                  error = false;
                                });
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "WorkSans",
                              fontSize: 20.0,
                            ),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: error
                                      ? const BorderSide(color: Colors.red)
                                      : const BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: isTimer
                            ? () {}
                            : () {
                                setState(() {
                                  _start = 60;
                                  startTimer();
                                  isTimer = true;
                                });
                                showAlertDialog(
                                    context,
                                    "Resending Code",
                                    "Please Wait",
                                    "We Are Sending New OTP to Your Mobile Number +977${widget.number} to Reauthenticate.",
                                    "loading.json",
                                    false);
                                _auth.verifyPhoneNumber(
                                    timeout: const Duration(seconds: 60),
                                    phoneNumber: '+977${widget.number}',
                                    verificationCompleted:
                                        (phoneauthCredential) async {},
                                    verificationFailed:
                                        (verificationFailed) async {},
                                    codeSent:
                                        (verifictionID, resendingToken) async {
                                      setState(() {
                                        widget.otp = verifictionID;
                                      });
                                      Navigator.pop(context);
                                      showAlertDialog(
                                          context,
                                          "Code Sent",
                                          "Successful",
                                          "We Have Sent 6 Digit Code In Given Mobile Number. Please Verify it To Complete Registration.",
                                          "success.json",
                                          false);
                                      await Future.delayed(
                                          const Duration(seconds: 2));
                                      if (!mounted) return;
                                      Navigator.pop(context);
                                    },
                                    codeAutoRetrievalTimeout:
                                        (verificationID) async {
                                      Navigator.pop(context);
                                      showAlertDialog(
                                          context,
                                          "Failed To Authenticate",
                                          "Timeout Occured",
                                          "Please Check The Details Again Before Authenricating. Check Your Mobile Number Again And Continue.",
                                          "failed.json",
                                          true);
                                    });
                              },
                        child: isTimer
                            ? Text(
                                _start.toString(),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: "WorkSans",
                                  color: Colors.white,
                                ),
                              )
                            : const Text("Resend Code",
                                style: TextStyle(
                                    fontFamily: "WorkSans",
                                    fontSize: 15.0,
                                    color: Colors.white,
                                    decoration: TextDecoration.underline)),
                      )
                    ],
                  ),
                ],
              ))),
              AnimatedContainer(
                height: _height,
                width: _width,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ElevatedButton(
                    onPressed: _pressed
                        ? () {}
                        : () async {
                            //button animation

                            FocusScope.of(context)
                                .requestFocus(FocusNode()); //disabling keyboard
                            final enteredOtp = firstController.text +
                                secondController.text +
                                thirdController.text +
                                fourthController.text +
                                fifthController.text +
                                sixthController.text;
                            if (enteredOtp.length == 6) {
                              setState(() {
                                _pressed = true;
                                _width = 80;
                              });
                              firstController.clear();
                              secondController.clear();
                              thirdController.clear();
                              fourthController.clear();
                              fifthController.clear();
                              sixthController.clear();
                              PhoneAuthCredential phoneAuthCredential =
                                  PhoneAuthProvider.credential(
                                      verificationId: widget.otp,
                                      smsCode: enteredOtp);
                              verifyCredential(phoneAuthCredential);
                            } else {
                              setState(() {
                                error = true;
                              });
                            }
                          },
                    style: _pressed
                        ? ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            primary: _success ? color : Colors.blue)
                        : ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Color_Green),
                          ),
                    child: _pressed
                        ? (_success
                            ? icon
                            : const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ))
                        : Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.all(16.0),
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                "Verify & Register",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "WorkSans",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
