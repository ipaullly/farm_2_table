import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final TextInputType keyboardType;
  final Function(String) validator;
  final bool obscureText;

  CustomTextFormField({
    this.controller,
    this.hintText,
    this.labelText,
    this.keyboardType,
    this.validator,
    this.obscureText: false
  });

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Theme(
        data: theme.copyWith(
          primaryColor: theme.accentColor,
          hintColor: Colors.grey[500],
          errorColor: Colors.redAccent,
        ),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                  labelText,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: theme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  )
              ),
              TextFormField(
                cursorColor: Colors.grey[850],
                style: TextStyle(color: Colors.grey[850]),
                controller: controller,
                decoration: InputDecoration(
                    hintText: hintText,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: theme.primaryColor)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: theme.primaryColor)),
                    disabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: theme.primaryColor))
                ),
                keyboardType: keyboardType,
                obscureText: obscureText,
                validator: validator,
              ),
            ],
          ),
        )
    );
  }
}