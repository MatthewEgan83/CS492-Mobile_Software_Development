/*
  Model class to handle posting to firestore
*/


class WastePost {
  var document;// = Firestore.instance.collection('posts');

  final dateUploaded;
  final imageUrl;
  final quantity;
  final latitude;
  final longitude;

  WastePost(this.document, this.dateUploaded, this.imageUrl, this.quantity, this.latitude, this.longitude);

  void postWaste(){
    document.add({
      'date_uploaded': dateUploaded,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    }
    );
  }
}