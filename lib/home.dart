import 'package:flutter/material.dart';
import 'package:flutter_animated_rectangle/animation.dart';

class RedRectangleAnimated extends StatefulWidget {
  @override
  _RedRectangleAnimatedState createState() => _RedRectangleAnimatedState();
}

class _RedRectangleAnimatedState extends State<RedRectangleAnimated>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  // initiate animation for rectangle
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -1.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // Widget built as the primary layout
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            _controller.forward().then((value) => _controller.reverse());
          });
        },
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Stack(children: [
                      for (int i=0;i<=10000;i=i+1000)
                        GreenBoxGenerator(delay: i,),
                    ],),
                    Center(child: animatedBox(50, 100, Colors.red)),
                  ],
                ),
                Divider(
                  thickness: 10,
                  indent: 0,
                  height: 0,
                  color: Colors.red,
                ),
              ],
            )));
  }

  //animated rectangle
  Widget animatedBox(double w, double h, Color colors) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        width: w,
        height: h,
        color: colors,
      ),
    );
  }
}