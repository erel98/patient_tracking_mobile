import 'package:flutter/material.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:bordered_text/bordered_text.dart';

class AnaMenuItem extends StatelessWidget {
  String menuText;
  String route;
  Icon icon;
  AnaMenuItem(this.menuText, this.route, this.icon);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      splashColor: Colors.grey,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: kMenuItemColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: []),
        child: Center(
          child: Column(
            children: [
              Container(
                child: icon,
                margin: EdgeInsets.only(bottom: 5),
              ),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: BorderedText(
                  strokeWidth: 1,
                  strokeColor: Colors.black,
                  child: Text(
                    menuText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
