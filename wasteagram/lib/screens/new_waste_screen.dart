import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';
import 'package:wasteagram/screens/list_screen.dart';
import 'package:wasteagram/models/food_waste_post.dart';

class NewWasteScreen extends StatefulWidget{
  final File image;
  final url;
  int itemsWasted;
  double latitude;
  double longitude;
  var date = DateTime.now();
  var collection = Firestore.instance.collection('posts');  
  NewWasteScreen(this.image, this.url);
  @override
  _NewWasteScreenState createState() => _NewWasteScreenState();

  void makePost(){
    var post = WastePost(collection, date, url, itemsWasted, latitude, longitude);
    post.postWaste();
  }
}

class _NewWasteScreenState extends State<NewWasteScreen> {
  final _formKey = GlobalKey<FormState>();
  LocationData locationData;
  @override
  void initState(){
    super.initState();
    retrieveLocation();
  }

  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState( () {} );
  }
  @override
  Widget build(BuildContext context){
    print(locationData.latitude);
    if (locationData == null)
      return Center(child: CircularProgressIndicator() );
    else {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Wasteagram'),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ListScreen()
                )
            );
          }
          ),
        ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.file(widget.image, height: 300, width: 200),
            //SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    labelText: 'Number of items',
                    border: OutlineInputBorder()
                  ),
                  inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  validator: (value){
                    var wastecount = int.tryParse(value);
                    if (wastecount == null || wastecount < 0)
                      return 'Enter a non-negative number';
                    else if (value.isEmpty)
                      return 'Please enter a quantity';
                    else
                      return null;
                  },
                  //onSaved: (value) => widget.itemsWasted = int.parse(value)
                    onSaved: (value){
                      widget.latitude = locationData.latitude;
                      widget.longitude = locationData.longitude;
                      widget.itemsWasted = int.parse(value);
                    }
                  ),
                  MaterialButton(
                    onPressed: () {
                      if (_formKey.currentState.validate())
                      {
                        _formKey.currentState.save();
                      }
                      widget.makePost();
                      Navigator.push(
                        context,
                          MaterialPageRoute(
                            builder: (context) => ListScreen()
                          )
                      );
                    },
                    child: Icon(Icons.cloud_download),
                    color: Colors.redAccent,
                    minWidth: 150,
                    elevation: 8,
                    highlightElevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    )
                ],
              )
            ),
            
          ],
        ),
      ),
      );
    }
    
    
  }
}