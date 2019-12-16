import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:kobe_movie_challenge/screens/home_page.dart';
import 'package:kobe_movie_challenge/widgets/stagger_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

/// SingleTickerProviderStateMixin always get when the screen is render

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  /// Animation controller is responsible to all animations

  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    animationController.addStatusListener((status){
      if(status == AnimationStatus.completed){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
      }
    });
  }

  /// Use dispose to not use  data from the app
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.5;
    return Scaffold(
      body: Container(
        child: StaggerAnimation(
            controller: animationController.view
        ),
      ),
    );
  }
}
