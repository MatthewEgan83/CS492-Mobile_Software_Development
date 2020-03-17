import 'package:test/test.dart';
import 'package:wasteagram/models/food_waste_post.dart';

void main(){
  //test to check class is initialized properly
  test('All fields should be initialized for post', (){
    final document = 'Snapshot';
    final date = DateTime.parse('2020-03-16');
    const url = 'PhotoUrl';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = -1.0;

    final post = WastePost(document, date, url, quantity, latitude, longitude);

    expect(post.document, document);
    expect(post.dateUploaded, date);
    expect(post.imageUrl, url);
    expect(post.quantity, quantity);
    expect(post.latitude, latitude);
    expect(post.longitude, longitude);
  });

  test('All fields should get added to document', () {
    var document = [];
    final date = DateTime.now();
    const url = 'PhotoUrl';
    const quantity = 1;
    const latitude = 1.0;
    const longitude = -1.0;

    final post = WastePost(document, date, url, quantity, latitude, longitude);
    post.postWaste();
    var mappedPost = {
      'date_uploaded': date,
      'imageUrl': url,
      'quantity': quantity,
      'latitude': latitude,
      'longitude': longitude
    };
    expect(post.document[0], mappedPost);
  });

}