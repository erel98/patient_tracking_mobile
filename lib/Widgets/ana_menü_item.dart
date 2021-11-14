import 'package:flutter/material.dart';
import 'package:patient_tracking/constraints.dart';

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
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  menuText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              Container(
                child: icon,
                margin: EdgeInsets.only(top: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
