import 'package:flutter/material.dart';
class Button
{
  // ignore: prefer_typing_uninitialized_variables
  final id;
  Color bg;
  String text;
  bool enabled;
  
  Button({this.id,this.text="",this.bg= Colors.yellow,this.enabled=true});

}