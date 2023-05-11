import 'package:flutter/material.dart';

const inputDecorationStyle = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.black
    ),
  ),
  enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: Colors.black
      )
  ),
  errorStyle: TextStyle(
    color: Colors.red,
  ),
);