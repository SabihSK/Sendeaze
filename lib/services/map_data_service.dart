import 'package:http/http.dart' as http;
import 'package:sendeaze/models/map_data_controller.dart';

class MapPolylineApi {
  Future<Googlemapapi> getMapPolyline(originLatitude, originLongitude,
      destinationLongitude, destinationLatitude) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://maps.googleapis.com/maps/api/directions/json?origin=$originLatitude,$originLongitude&destination=$destinationLongitude,$destinationLatitude&mode=driving&key=AIzaSyBwviQE9Walln3RAHLawdQDbOpN0q0Jcg8'));

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      // print(response.body);
      var data = googlemapapiFromJson(response.body);
      print(data.routes[0].overviewPolyline.points);
      // print(response);
      return data;
    } else {
      print(response);
    }

    return googlemapapiFromJson(response.body);
  }
}
