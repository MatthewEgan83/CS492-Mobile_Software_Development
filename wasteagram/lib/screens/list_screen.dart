import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:wasteagram/screens/waste_detail_screen.dart';
import 'package:wasteagram/screens/camera_screen.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            Text('Wasteagram '),
            StreamBuilder(
              stream: Firestore.instance.collection('posts').snapshots(),
              builder: (content, snapshot){
                if (snapshot.hasData)
                  return Text(snapshot.data.documents.length.toString());
                else
                  return Text('0'); 
              }
            )
          ],
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('posts').snapshots(),
        builder: (content, snapshot){
          if (snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0){
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context,index) {
                var post = snapshot.data.documents[index];
                return Semantics(
                  child: ListTile(
                    title: Text(post['date_uploaded'].toDate().toString()),
                    trailing: Text(post['quantity'].toString()),
                    onTap: () {
                      Navigator.push(
                        context,
                          MaterialPageRoute(
                            builder: (context) => WasteDetailScreen(snapshot: snapshot.data.documents[index],)
                          )
                      );
                    },
                  ),
                  button: true,
                  enabled: true,
                  onTapHint: 'View post in detail',
                );
                
              }
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
      }
    ),
      floatingActionButton: Semantics(
        child: FloatingActionButton.extended(
          label: Text('Add New Waste'),
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraFab()));},
        ),
        button: true,
        enabled: true,
        onTapHint: 'Select an image',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  
}



