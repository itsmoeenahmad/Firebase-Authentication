
import 'package:flutter/material.dart';

class check_state extends ChangeNotifier
{
  bool check = true;

  void change_state(bool value)
  {
    check = value;
    ChangeNotifier();
  }

}