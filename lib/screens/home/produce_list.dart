import 'package:farm_2_table/models/produce.dart';
import 'package:farm_2_table/screens/home/produce_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProduceList extends StatefulWidget {
  @override
  _ProduceListState createState() => _ProduceListState();
}

class _ProduceListState extends State<ProduceList> {
  @override
  Widget build(BuildContext context) {
    final produce = Provider.of<List<Produce>>(context);
    return ListView.builder(
      itemCount: produce.length,
      itemBuilder: (context, index){
        return ProduceTile(produce: produce[index]);
      },
    );
  }
}
