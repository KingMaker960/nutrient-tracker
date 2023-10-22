import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:manipal/LoginScreen.dart';
import 'package:manipal/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manipal/otpverification.dart';
import 'package:manipal/widgets/customnavigation.dart';
import 'package:manipal/widgets/sqlqueries.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final numberController = TextEditingController();
  final rollnumberController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _error = false;

  String head = "Authenticating";
  String subHead = "Please Wait";
  String details =
      "We Need To Verify Your Phone Number So Sending OTP to Given Number";
  String lottieName = "loading.json";
  //name validator
  bool _isNtouched = false;
  String? get _nameerrortext {
    final name = nameController.value.text;
    if (name.isEmpty) {
      return "Enter valid Name";
    }
    return null;
  }

  //age validtor
  bool _isAtouched = false;
  String? get _ageerrortext {
    final age = ageController.value.text;
    if (age.isEmpty) {
      return "Enter valid Age";
    } else if (int.parse(age) < 16) {
      return "You Are Too Young To Use App";
    }
    return null;
  }

  //number validator
  bool _isNumbertouched = false;
  String? get _numbererrortext {
    final number = numberController.value.text;
    if (number.isEmpty) {
      return "Enter valid Number";
    } else if (number.length < 10) {
      return "Enter valid Number";
    }
    return null;
  }

  //roll number validator
  bool _isUtouched = false;
  String? get _uerrortext {
    final rollnumber = rollnumberController.value.text;
    if (rollnumber.isEmpty) {
      return "Enter valid Roll Number";
    }
    return null;
  }

  //passsword validity checker
  bool _isVisible = false;
  bool _isPtouched = false;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;
  String? get _perrortext {
    final password = passwordController.value.text;
    if (password.isEmpty) {
      return "Password can't be empty";
    } else if (password.length < 8) {
      setState(() {
        password_strength = 1 / 3;
      });
      return "Password Length Should be 8";
    } else {
      if (pass_valid.hasMatch(password)) {
        setState(() {
          password_strength = 3 / 3;
        });
      } else {
        setState(() {
          password_strength = 2 / 3;
        });
        return "Contain Capital, Number And Special Character";
      }
    }
    return null;
  }
  //end of password validity checker

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color_Blue,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
              top: 15.0, left: 15.0, right: 15.0, bottom: 35.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //top back button
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      FontAwesomeIcons.arrowLeftLong,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),

              // App Icon Showing

              //login ui area

              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin:
                              const EdgeInsets.only(top: 15.0, bottom: 25.0),
                          child: const Center(
                            child: Text(
                              "JOIN US",
                              style: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 50.0,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        // name
                        TextField(
                          controller: nameController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "WorkSans",
                            fontSize: 15.0,
                          ),
                          cursorColor: Colors.white,
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          onTap: () {
                            setState(() {
                              _isNtouched = true;
                            });
                          },
                          onChanged: (text) {
                            setState(() {
                              _error = false;
                            });
                          },
                          decoration: InputDecoration(
                              errorText: _isNtouched ? _nameerrortext : null,
                              errorStyle: const TextStyle(
                                  fontFamily: "WorkSans", fontSize: 12.0),
                              labelText: "Full Name",
                              prefixIcon: const Icon(
                                FontAwesomeIcons.user,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: _error
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red))
                                  : UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "WorkSans",
                                  fontSize: 15.0),
                              focusColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        //age
                        TextField(
                          controller: ageController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "WorkSans",
                            fontSize: 15.0,
                          ),
                          cursorColor: Colors.white,
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          onTap: () {
                            setState(() {
                              _isAtouched = true;
                            });
                          },
                          onChanged: (text) {
                            setState(() {
                              _error = false;
                            });
                          },
                          decoration: InputDecoration(
                              errorText: _isAtouched ? _ageerrortext : null,
                              errorStyle: const TextStyle(
                                  fontFamily: "WorkSans", fontSize: 12.0),
                              labelText: "Age",
                              prefixIcon: const Icon(
                                FontAwesomeIcons.clock,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: _error
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red))
                                  : UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "WorkSans",
                                  fontSize: 15.0),
                              focusColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        // number
                        TextField(
                          controller: numberController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "WorkSans",
                            fontSize: 15.0,
                          ),
                          cursorColor: Colors.white,
                          obscureText: false,
                          keyboardType: TextInputType.phone,
                          onTap: () {
                            setState(() {
                              _isNumbertouched = true;
                            });
                          },
                          onChanged: (text) {
                            setState(() {
                              _error = false;
                            });
                          },
                          decoration: InputDecoration(
                              errorText:
                                  _isNumbertouched ? _numbererrortext : null,
                              errorStyle: const TextStyle(
                                  fontFamily: "WorkSans", fontSize: 12.0),
                              labelText: "Number",
                              prefixIcon: const Icon(
                                FontAwesomeIcons.phone,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: _error
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red))
                                  : UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "WorkSans",
                                  fontSize: 15.0),
                              focusColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        //roll number

                        TextField(
                          controller: rollnumberController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "WorkSans",
                            fontSize: 15.0,
                          ),
                          cursorColor: Colors.white,
                          obscureText: false,
                          onTap: () {
                            setState(() {
                              _isUtouched = true;
                            });
                          },
                          onChanged: (text) {
                            setState(() {
                              _error = false;
                            });
                          },
                          decoration: InputDecoration(
                              errorText: _isUtouched ? _uerrortext : null,
                              errorStyle: const TextStyle(
                                  fontFamily: "WorkSans", fontSize: 12.0),
                              labelText: "Roll Number",
                              prefixIcon: const Icon(
                                FontAwesomeIcons.idBadge,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: _error
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red))
                                  : UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "WorkSans",
                                  fontSize: 15.0),
                              focusColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),

                        // password textbox

                        TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "WorkSans",
                            fontSize: 15.0,
                          ),
                          controller: passwordController,
                          cursorColor: Colors.white,
                          obscureText: _isVisible ? false : true,
                          onTap: () {
                            setState(() {
                              _isPtouched = true;
                            });
                          },
                          onChanged: (text) {
                            setState(() {
                              _error = false;
                            });
                          },
                          decoration: InputDecoration(
                              errorText: _isPtouched ? _perrortext : null,
                              errorStyle: TextStyle(
                                  fontFamily: "WorkSans",
                                  fontSize: 12.0,
                                  color: password_strength == 2 / 3
                                      ? Colors.yellow
                                      : Colors.red),
                              labelText: "Password",
                              prefixIcon: const Icon(
                                Icons.lock_outline,
                                size: 18.0,
                                color: Colors.white,
                              ),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isVisible = !_isVisible;
                                  });
                                },
                                child: Icon(
                                  _isVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  size: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              filled: true,
                              fillColor: Color_grayBlue,
                              enabledBorder: _error
                                  ? OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide:
                                          const BorderSide(color: Colors.red))
                                  : UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              errorBorder: UnderlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: (password_strength == 2 / 3)
                                      ? const BorderSide(color: Colors.yellow)
                                      : const BorderSide(color: Colors.red)),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "WorkSans",
                                  fontSize: 15.0),
                              focusColor: Colors.white),
                        ),
                        const SizedBox(
                          height: 12.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (_uerrortext == null &&
                          _nameerrortext == null &&
                          password_strength == 1 &&
                          _ageerrortext == null &&
                          _numbererrortext == null) {
                        setState(() {
                          head = "Authenticating";
                          subHead = "Please Wait";
                          details =
                              "We Need To Verify Your Phone Number So Sending OTP to Given Number";
                          lottieName = "loading.json";
                        });

                        showAlertDialog(
                            context, head, subHead, details, lottieName, false);
                        List result = await registerAuthenticate(
                          numberController.value.text,
                          rollnumberController.value.text,
                        );
                        if (!mounted) return;
                        Navigator.pop(context);
                        showAlertDialog(context, result[0], result[1],
                            result[2], result[3], result[4]);
                        if (!result[4]) {
                          _auth.verifyPhoneNumber(
                              timeout: const Duration(seconds: 60),
                              phoneNumber: '+977${numberController.text}',
                              verificationCompleted:
                                  (phoneAuthCredential) async {},
                              verificationFailed: (verificationFailed) async {
                                setState(() {
                                  head = "Failed To Authenticate";
                                  subHead = "System Error";
                                  details = verificationFailed.message!;
                                  lottieName = "failed.json";
                                });
                                Navigator.pop(context);
                                showAlertDialog(context, head, subHead, details,
                                    lottieName, true);
                              },
                              codeSent: (verificationID, resendingToken) async {
                                setState(() {
                                  head = "Code Sent";
                                  subHead = "Successful";
                                  details =
                                      "We Have Sent 6 Digit Code In Given Mobile Number. Please Verify it To Complete Registration.";
                                  lottieName = "success.json";
                                });
                                Navigator.pop(context);
                                showAlertDialog(context, head, subHead, details,
                                    lottieName, false);
                                await Future.delayed(
                                    const Duration(milliseconds: 2200));
                                if (!mounted) return;
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                    context,
                                    CustomPageRoute(
                                        child: OtpLogin(
                                      name: nameController.value.text,
                                      age: ageController.value.text,
                                      number: numberController.value.text,
                                      rollnumber:
                                          rollnumberController.value.text,
                                      password: passwordController.value.text,
                                      otp: verificationID,
                                    )));
                              },
                              codeAutoRetrievalTimeout: (verificationID) async {
                                setState(() {
                                  head = "Failed To Authenticate";
                                  subHead = "Timeout Occured";
                                  details =
                                      "Please Check The Details Again Before Authenricating. Check Your Mobile Number Again And Continue.";
                                  lottieName = "failed.json";
                                });
                                showAlertDialog(context, head, subHead, details,
                                    lottieName, true);
                              });
                        }
                      } else if (nameController.value.text == '' ||
                          ageController.value.text == '' ||
                          numberController.value.text == '' ||
                          rollnumberController.value.text == '' ||
                          passwordController.value.text == '') {
                        setState(() {
                          _error = true;
                        });
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color_Green),
                    ),
                    child: Container(
                      color: Colors.transparent,
                      margin: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      child: const Center(
                        child: Text(
                          "Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "WorkSans",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Already Have an Account?",
                    style: TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 15.0,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  InkWell(
                    focusColor: Color_Green,
                    hoverColor: Color_Green,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
