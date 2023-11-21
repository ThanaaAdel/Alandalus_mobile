import 'dart:async';

import 'package:alandalos/core/extensions/num_extensions.dart';
import 'package:alandalos/core/routing/route.dart';
import 'package:alandalos/screens/auth/login/auth_provider.dart';
import 'package:alandalos/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../utils/res.dart';
import '../../data/repository/SaveUserData.dart';
import '../../injection.dart';
import '../children/children_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  SaveUserData sp = getIt();
  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this);
    Timer(const Duration(seconds: 3), () {
      if (sp.getUserData()?.data?.id !=null) {
        Provider.of<AuthProvider>(context,listen: false).updateFCMToken();
        pushAndRemoveUntil(const ChildrenScreen());
      }
      else{
        pushAndRemoveUntil(const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(backgroundColor: Colors.white,
      body: Stack(
              children: [
                Center(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.transparent,
                    // decoration: const BoxDecoration(
                    //     gradient: LinearGradient(
                    //         begin: Alignment.centerLeft,
                    //         end: Alignment.centerRight,
                    //         colors: [AppColors.colorPrimaryGradient, AppColors.colorPrimary])),
                    child: SizedBox.expand(
                        child:
                        Column(crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
                              child: Image.asset('assets/images/splashLoge.png',
                                  fit: BoxFit.cover,

                    //         repeat: false, animate: true, onLoaded: (lottie) {
                    //   controller
                    //     ..duration = lottie.duration
                    //     ..forward().whenComplete(() {
                    //       // provider.initFunction(context);
                    //     });
                    // }
                    ),
                            ),
                          ],
                        )
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SvgPicture.asset(
                    'assets/icons/ic_pattern.svg',
                    width: 150,
                    height: 150,
                  ),
                )
              ],
            ),
    );
  }
}
