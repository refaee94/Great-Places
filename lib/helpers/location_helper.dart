import 'dart:convert';

import 'package:http/http.dart' as http;

// 
class LocationHelper {
  static String generatePrev({double longt,double lat}){
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$lat,$longt&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$longt&key=$GOOGLE_API_KEY';
    }

  static Future<String> getLocation({double longt,double lat})async{

    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$longt&key=$GOOGLE_API_KEY';
final response=await http.get(url);
    return json.decode(response.body)['results'][0]['formatted_address'];

  }


}