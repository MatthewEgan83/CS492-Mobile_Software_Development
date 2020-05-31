import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:wasteagram/screens/new_waste_screen.dart';

class CameraFab extends StatefulWidget {
  @override
  _CameraFabState createState() => _CameraFabState();
}

class _CameraFabState extends State<CameraFab> {
  File image;
  var url;

  void getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);
    StorageReference storageReference =
      FirebaseStorage.instance.ref().child(Path.basename(image.path));
    StorageUploadTask uploadTask = storageReference.putFile(image);
    await uploadTask.onComplete;
    url = await storageReference.getDownloadURL();
    print(url);
    setState( () {} );
  }
  Widget build(BuildContext context){
    if (image == null){
      return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
          centerTitle: true,        
        ),
        body: Center(
          child: Semantics(
            child:RaisedButton(
              child: Text('Take photo'),
              onPressed: () {
                getImage();
              },
            ),
            button: true,
            enabled: true,
            onTapHint: 'Start camera to take picture',
        ), 
          
        ),
      );
    } else 
    {
      return Scaffold(
        appBar: AppBar(
          title: Text('Wasteagram'),
          centerTitle: true,        
        ),
        body: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Semantics(
                  child: Image.file(image, height: 300, width: 200),
                  image: true,
                  hint: 'Photo that was taken',
                ),
                Semantics(
                  child: RaisedButton(
                    child: Text('Post photo'),
                    onPressed: () {
                       Navigator.push(
                         context, 
                         MaterialPageRoute(
                           builder: (context) => NewWasteScreen(image, url),
                         ),
                       );
                      }
                  ),
                  button: true,
                  enabled: true,
                  onTapHint: 'Post photo that was taken',
                ),
              ],
            ),
          )
        )
      );
    }
    
  }
}