import 'package:farm_2_table/models/produce.dart';
import 'package:farm_2_table/screens/home/produce-list.dart';
import 'package:farm_2_table/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm_2_table/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Produce>>.value(
      value: DatabaseService().produce,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text('F2T'),
          backgroundColor: Colors.lightGreen[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              label: Text('logout'),
              icon: Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: ProduceList(),
      ),
    );
  }
}
