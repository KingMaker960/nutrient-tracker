// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'dart:ffi';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:manipal/widgets/sqlqueries.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  //animation transition

  late AnimationController animationController;
  late Animation<double> animation;
  bool _pressed = false;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
//animation finished

  // backPressed() {
  //   return showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //             title: const Text("Do You  Really Want To Exit App ?"),
  //             actions: [
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.pop(context, false);
  //                   },
  //                   child: const Text("Yes")),
  //               FlatButton(
  //                   onPressed: () {
  //                     Navigator.pop(context, true);
  //                   },
  //                   child: const Text("No"))
  //             ],
  //           ));
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Scaffold(
          backgroundColor: Color_white,
          body: CircularRevealAnimation(
            centerAlignment: const Alignment(-0.01, 0.485),
            child: Container(
              color: Color_Blue,
            ),
            animation: animation,
            minRadius: 5,
            maxRadius: 1000,
          ),
        )),
        !_pressed
            ? Positioned(
                child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: SafeArea(
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 10.0, left: 12.0, right: 15.0, bottom: 35.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // backPressed();
                                  },
                                  child: Container(
                                    height: 46,
                                    width: 46,
                                    child: const Icon(
                                      FontAwesomeIcons.angleLeft,
                                      // size: 28.0,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color_gray,
                                        borderRadius:
                                            BorderRadius.circular(13.0)),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    animate();
                                  },
                                  child: const Text(
                                    "Skip",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: "WorkSans",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Center(
                              child:
                                  Image.asset("assets/images/startup_icon.jpg"),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            const Text(
                              "Nutrient Tracker",
                              style: TextStyle(
                                  fontSize: 32.0,
                                  fontFamily: "WorkSans",
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "Track Your Diet & Health Regularly. Robotics Club IOE Paschimanchal Campus.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 18.0, fontFamily: "WorkSans"),
                            ),
                            const SizedBox(
                              height: 35.0,
                            ),
                            // Container(
                            //   height: 8,
                            //   width: 20,
                            //   decoration: BoxDecoration(
                            //       color: Color_Blue,
                            //       borderRadius: BorderRadius.circular(15.0)),
                            // ),
                            Expanded(child: Container()),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    animate();
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0))),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color_Blue),
                                  ),
                                  child: Container(
                                    color: Colors.transparent,
                                    margin: const EdgeInsets.all(17.0),
                                    width: double.infinity,
                                    child: const Center(
                                      child: Text(
                                        "Get Started",
                                        style: TextStyle(
                                            color: Colors.white,
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
                    )),
              )
            : const Positioned(
                child: SizedBox(),
              ),
      ],
    );
  }

  void animate() async {
    animationController.forward();
    await Future.delayed(Duration(milliseconds: 400));
    setState(() {
      _pressed = true;
    });
    await animationController.forward();
    // final SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance();
    // sharedPreferences.setString('visited', 'true');
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => const LoginScreen(),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
