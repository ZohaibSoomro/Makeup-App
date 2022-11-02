import 'package:flutter/material.dart';

const kTitleStyle = TextStyle(fontSize: 70);
const kTextStyle = TextStyle(color: Colors.black54);
const kTextFieldDecoration = InputDecoration(
  hintText: 'enter a value',
  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30)),
  ),
);
