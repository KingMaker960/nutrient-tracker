import 'package:flutter/material.dart';
import 'package:manipal/HomeScreen.dart';
import 'package:manipal/RegisterScreen.dart';
import 'package:manipal/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:manipal/widgets/customnavigation.dart';
import 'package:manipal/widgets/sqlqueries.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _error = false;
  bool _isVisible = false;
  bool _isUtouched = false;
  bool _isPtouched = false;
  final _usercontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  //for dialog box
  String head = "Verifying Details";
  String subHead = "Please Wait";
  String details =
      "Please Wait While We Verify Your Details. You Will Be Redirected Automatically.";
  String lottieFile = "loading.json";
  bool isdismissable = false;

  String? get _uerrortext {
    final rollnumber = _usercontroller.value.text;
    if (rollnumber.isEmpty) {
      return "Enter valid Roll Number";
    }
    return null;
  }

  String? get _perrortext {
    final password = _passwordcontroller.value.text;
    if (password.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }

  @override
  void dispose() {
    _usercontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                    onTap: () {},
                    child: const Icon(
                      FontAwesomeIcons.arrowLeftLong,
                      size: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              //login ui area
              // const SizedBox(
              //   height: 15.0,
              // ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // App Icon Showing

                      Container(
                        alignment: Alignment.topCenter,
                        height: 0.35 * size.height,
                        margin: const EdgeInsets.only(bottom: 25.0),
                        child: Image.asset(
                          "assets/images/logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      //rollnumber TextBox

                      TextField(
                        controller: _usercontroller,
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
                        controller: _passwordcontroller,
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
                            errorStyle: const TextStyle(
                                fontFamily: "WorkSans",
                                fontSize: 12.0,
                                color: Colors.red),
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
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            labelStyle: const TextStyle(
                                color: Colors.white,
                                fontFamily: "WorkSans",
                                fontSize: 15.0),
                            focusColor: Colors.white),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              focusColor: Color_Green,
                              hoverColor: Color_Green,
                              onTap: () {},
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    fontFamily: "WorkSans",
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                    ],
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
                      if (_usercontroller.value.text == '' ||
                          _passwordcontroller.value.text == '') {
                        setState(() {
                          _error = true;
                        });
                      } else if (_uerrortext == null && _perrortext == null) {
                        showAlertDialog(context, head, subHead, details,
                            lottieFile, isdismissable);
                        List result = await loginAuthenticate(
                            _usercontroller.value.text,
                            _passwordcontroller.value.text);
                        if (!mounted) return;
                        Navigator.pop(context);
                        showAlertDialog(context, result[0], result[1],
                            result[2], result[3], result[4]);
                        if (!result[4]) {
                          //Navigate to Home
                          await Future.delayed(const Duration(seconds: 2));

                          final SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              'rollnumber', _usercontroller.value.text);
                          if (!mounted) return;
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(context,
                              CustomPageRoute(child: const HomeScreen()));
                        }
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
                          "Login",
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
                    "Don't Have an Account?",
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
                      Navigator.push(context,
                          CustomPageRoute(child: const RegisterScreen()));
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          fontFamily: "WorkSans",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String head, String subHead,
    String details, String lottie, bool isdismissable) async {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5.0),
            height: isdismissable ? 225 : 175,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: lottie == "success.json"
                          ? const EdgeInsets.all(5)
                          : const EdgeInsets.all(3),
                      child: Lottie.asset("assets/images/$lottie",
                          height: 65, width: 65, fit: BoxFit.fill),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            head,
                            style: const TextStyle(
                                fontFamily: "WorkSans",
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(
                            subHead,
                            style: const TextStyle(
                                fontFamily: "WorkSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Color_Blue,
                  width: double.maxFinite,
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 8),
                  child: Text(
                    details,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontFamily: "WorkSans",
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Visibility(
                  visible: isdismissable,
                  child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50.0),
                        height: 44,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Color_Blue)),
                          child: const Text(
                            "Okay",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "WorkSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),
        );
      });
}
