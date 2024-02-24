

import 'package:flutter/cupertino.dart';

class login_loadingstate extends ChangeNotifier
{
  bool check = false;

  void change_state()
  {
    check = !check;
    notifyListeners();
  }
}