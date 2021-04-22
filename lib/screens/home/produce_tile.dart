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
            title: Text(produce.produceName),
            subtitle: Padding(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 5.0),
              child: Text(
                'Minimum unit of sale is ${produce.minUnit} ${produce.unitMeasure} at KES ${produce.price}',
                style: TextStyle(
                  color: Colors.grey[12],
                  fontSize: 12,
                  fontStyle: FontStyle.italic
                ) ,
              ),
            ),
          ),
        ),
    );
  }
}
