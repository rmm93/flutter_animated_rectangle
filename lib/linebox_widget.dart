import 'package:flutter/material.dart';

class AnimeBox extends StatefulWidget {
  @override
  _AnimeBoxState createState() => _AnimeBoxState();
}

class _AnimeBoxState extends State<AnimeBox>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.0, -0.5),
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
                SlideTransition(
                  position: _offsetAnimation,
                  child: Container(
                    width: 50,
                    height: 100,
                    color: Colors.red,
                  ),
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
}
