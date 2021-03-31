import 'package:farm_2_table/models/user.dart';
import 'package:farm_2_table/screens/authenticate/authenticate.dart';
import 'package:farm_2_table/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    // return home or Authenticate widget
    print(user);
    if(user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
