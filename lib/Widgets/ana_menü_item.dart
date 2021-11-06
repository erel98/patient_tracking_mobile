import 'package:flutter/material.dart';

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
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            children: [
              Flexible(
                child: Text(
                  menuText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              Container(
                child: icon,
                margin: EdgeInsets.only(top: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
