import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MultipleDelayedSlideAnimations());

class MultipleDelayedSlideAnimations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.white,
        child: SafeArea(child: Scaffold(body: buildBody())),
      ),
    );
  }

  Widget buildBody() {
    return Container(child: MultipleSlidingBox());
  }
}

class MultipleSlidingBox extends StatefulWidget {
  @override
  _MultipleSlidingBoxState createState() => _MultipleSlidingBoxState();
}

class _MultipleSlidingBoxState extends State<MultipleSlidingBox>
    with SingleTickerProviderStateMixin {
  Animation slidingAnimation;
  Animation delayedSlidingAnimation;
  Animation furtherDelayedSlidingAnimation;
  AnimationController slidingBoxAnimationController;

  @override
  void initState() {
    super.initState();

    slidingBoxAnimationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    slidingAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: slidingBoxAnimationController,
        curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn)));

    delayedSlidingAnimation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: slidingBoxAnimationController,
            curve: Interval(0.23, 1.0, curve: Curves.fastOutSlowIn)));

    furtherDelayedSlidingAnimation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: slidingBoxAnimationController,
            curve: Interval(0.43, 1, curve: Curves.fastOutSlowIn)));

    slidingBoxAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: slidingBoxAnimationController,
      builder: (BuildContext context, Widget child) {
        return Column(
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  slidingAnimation.value * width, 0.0, 0.0),
              child: Center(
                child: Container(height: 200, width: 200, color: Colors.teal,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Transform(
              transform: Matrix4.translationValues(
                  delayedSlidingAnimation.value * width, 0.0, 0.0),
              child: Center(
                child: Container(height: 200, width: 200, color: Colors.deepPurple),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Transform(
              transform: Matrix4.translationValues(
                  furtherDelayedSlidingAnimation.value * width, 0.0, 0.0),
              child: Center(
                child: Container(
                    height: 200, width: 200, color: Colors.pink),
              ),
            ),
          ],
        );
      },
    );
  }
}