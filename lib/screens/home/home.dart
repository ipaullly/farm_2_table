import 'package:farm_2_table/models/produce.dart';
import 'package:farm_2_table/screens/home/produce_list.dart';
import 'package:farm_2_table/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm_2_table/services/database.dart';
import 'package:farm_2_table/shared/constants.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel () {
      showModalBottomSheet(
        context: context,
        isDismissible: true,
        backgroundColor: Colors.grey[300],
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: AddProduceForm()
          );
        }
      );
    }

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
        body: Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              ProduceList(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight:  Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0),
                          bottomRight:  Radius.circular(10.0)
                        )
                      ),
                      child: FlatButton.icon(
                          color: Colors.deepOrange[300],
                          onPressed: () => _showSettingsPanel(),
                          icon: Icon(Icons.add),
                          label: Text('Add Produce')
                      ),
                    ),
                  ),
                ],
              )
            ]
        ),
      ),
    );
  }
}

class AddProduceForm extends StatefulWidget {

  @override
  _AddProduceFormState createState() => _AddProduceFormState();
}

class _AddProduceFormState extends State<AddProduceForm> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // add produce form fields
  String produceName = '';
  var price = 0.00;
  String imageUrl = '/place/holder/url';
  var minUnit = 0;
  String dropdownValue = 'Kg';
  String error = '';

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter a Name': null,
                onChanged: (val) {
                  setState(() {
                    produceName = val;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Name'),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Ensure you input produce price': null,
                keyboardType: TextInputType.number,
                // obscureText: true,
                onChanged: (val) {
                  double priceInput = double.parse(val);
                  setState(() {
                    price = priceInput;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Price'),
              ),
              SizedBox(height: 10.0),
              TextFormField(
                validator: (val) => _isNumeric(val) == false ? 'Ensure you input min unit of produce': null,
                keyboardType: TextInputType.number,
                // obscureText: true,
                onChanged: (val) {
                  int unitInput = int.parse(val);
                  setState(() {
                    minUnit = unitInput;
                  });
                },
                decoration: textInputDecoration.copyWith(hintText: 'Min Unit'),
              ),
              SizedBox(height: 10.0),
              DropdownButtonFormField(
                isExpanded: true,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 17,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                decoration: textInputDecoration.copyWith(hintText: 'Unit of Measure'),
                items: <String>['Kg', 'Litres', 'grammes', 'Debe']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                hint: Text(
                  "Please select a unit of measure for your produce",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500
                  ),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
              ),
              SizedBox(height: 15.0),
              RaisedButton(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 60.0),
                color: Colors.lightGreen,
                child: Text(
                  'Save Produce',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() {
                      loading = true;
                    });
                    print(minUnit);
                    dynamic result = DatabaseService()
                        .addProduce(produceName, price, minUnit, dropdownValue);
                    if(result == null){
                      setState(() {
                        error = 'please supply a valid email';
                        loading = false;
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
