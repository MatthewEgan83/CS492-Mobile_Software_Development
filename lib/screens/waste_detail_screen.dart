import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class WasteDetailScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  

  WasteDetailScreen({Key key, @required this.snapshot}) :
    super(key:key);

  @override
  Widget build (BuildContext context){
    var latitude = snapshot['latitude'].toString();
    var longitude = snapshot['longitude'].toString();
    return Scaffold(
      appBar: AppBar(
        title: Text('Wasteagram'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(DateFormat.yMMMd().format(snapshot['date_uploaded'].toDate()), 
              style: Theme.of(context).textTheme.display1
            ),
            Semantics(
              child:
                Image.network(snapshot['imageUrl'], height: 300, width: 200),
              image: true,
              hint: 'Image of wasted food',
            ),
            Text(snapshot['quantity'].toString(), style: Theme.of(context).textTheme.display1),
            Text('( $latitude,  $longitude )', style: Theme.of(context).textTheme.subhead)
          ],
        )
      )
    );
  }
}