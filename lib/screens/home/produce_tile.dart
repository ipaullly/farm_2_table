import 'package:flutter/material.dart';
import 'package:farm_2_table/models/produce.dart';

class ProduceTile extends StatelessWidget {
  final Produce produce;
  ProduceTile({ this.produce });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0) ,
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.lightBlue[20],
            ),
            title: Text(produce.name),
            subtitle: Text('Min unit is ${produce.minUnit} at ${produce.price}'),
          ),
        ),
    );
  }
}
