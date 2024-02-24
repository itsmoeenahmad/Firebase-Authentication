

import 'package:flutter/cupertino.dart';

class register_loadingstate extends ChangeNotifier
{
  bool check = false;

  void change_state()
  {
    if(check)
      {
        check = false;
      }
    else
      {
        check= true;
      }
    notifyListeners();
  }
}