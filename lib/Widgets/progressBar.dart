import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final Widget child;
  ProgressBar({this.child});

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: CircularProgressIndicator(),
      ),
      widget.child
    ]);
  }
}
