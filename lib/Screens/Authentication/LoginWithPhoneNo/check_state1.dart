
import 'package:flutter/material.dart';

class check_state1 extends ChangeNotifier
{
  bool check1 = true;

  void change_state1(bool value)
  {
    check1 = value;
    ChangeNotifier();
  }

}