import 'dart:async';

import 'package:flutter/material.dart';

class GreenBoxGenerator extends StatefulWidget {
  var delay;
  final Widget child;

  GreenBoxGenerator({@required this.child, this.delay});
  @override
  _GreenBoxGeneratorState createState() => _GreenBoxGeneratorState();
}

class _GreenBoxGeneratorState extends State<GreenBoxGenerator>
    with SingleTickerProviderStateMixin {
  AnimationController _grnBoxController;
  Animation<Offset> _offsetAnimation;

  @override
  void dispose() {
    super.dispose();
    _grnBoxController.dispose();
  }

  @override
  // initiate animation for Green Box
  void initState() {
    super.initState();
    _grnBoxController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(15, 0.0),
    ).animate(CurvedAnimation(
      parent: _grnBoxController,
      curve: Curves.decelerate,
    ));
    if (widget.delay == null) {
      _grnBoxController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _grnBoxController.forward();
        }
      });
    }
  }

  // building the green box
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(-1, -1),
      child: SlideTransition(
        position: _offsetAnimation,
        child: Container(
          height: 50,
          width: 50,
          color: Colors.green,
        ),
      ),
    );
  }

  void waitBeforeStart({@required int numberOfSeconds}) async {
    await Future.delayed(Duration(seconds: numberOfSeconds));
  }
}
