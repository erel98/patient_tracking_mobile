import 'package:flutter/material.dart';
import 'package:patient_tracking/constraints.dart';

class AnaMenuItem extends StatelessWidget {
  String menuText;
  String route;
  var icon;
  AnaMenuItem(this.menuText, this.route, this.icon);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: kMenuItemColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(-1, 1),
                spreadRadius: 1,
                blurRadius: 1,
                color: Colors.black.withOpacity(0.4))
          ]),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(route);
        },
        splashColor: Colors.grey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: icon,
                margin: EdgeInsets.only(bottom: 5),
              ),
              // SizedBox(
              //   height: menuText.length > 10 ? 15 : 20,
              // ),
              FittedBox(
                fit: BoxFit.fitHeight,
                child: Text(
                  menuText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kMenuTextColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
