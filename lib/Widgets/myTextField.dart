import 'package:flutter/material.dart';
import 'package:patient_tracking/constraints.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function onChanged;
  final TextInputType inputType;
  final bool enabled;
  MyTextField(
      {this.controller,
      this.hintText,
      this.onChanged,
      this.inputType,
      this.enabled});
  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 50,
            color: kPrimaryColor.withOpacity(0.23),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        enabled: widget.enabled,
        onChanged: widget.onChanged,
        keyboardType: widget.inputType,
        decoration: InputDecoration(
          label: Text('${widget.hintText}'),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          //hintText: widget.hintText,
          hintStyle: TextStyle(
            color: kPrimaryColor.withOpacity(0.5),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
