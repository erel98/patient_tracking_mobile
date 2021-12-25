import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  String print;
  NoDataFound(this.print);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrainst) {
      return Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.only(top: constrainst.maxHeight * 0.05),
              child: Text(
                '$print bulunmamaktadır',
                style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: constrainst.maxHeight * 0.05,
          ),
          Center(
            child: Container(
              height: constrainst.maxHeight * 0.5,
              child: Image.asset(
                'assets/images/waiting.png',
                color: Colors.grey.withOpacity(0.4),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    });
  }
}
