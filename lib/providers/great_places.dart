import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_complete_guide/helpers/db_helper.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';

import '../models/place.dart';

class GreatPlaces with ChangeNotifier {
    Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
    String pickedTitle,
    File pickedImage,
    PlaceLocation pickedLocation,
  ) async {
    final address = await LocationHelper.getLocation(
        lat: pickedLocation.latitude, longt: pickedLocation.longitude);
    final updatedLocation = PlaceLocation(
        latitude: pickedLocation.latitude,
        longitude: pickedLocation.longitude,
        address: address);
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: updatedLocation,
    );
    _items.add(newPlace);

    notifyListeners();
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lon': newPlace.location.longitude,
      'address': newPlace.location.address
    });
  }

  Future<void> getPlaces() async {
    final placesList = await DBHelper.getData('places');
    _items = placesList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            location: PlaceLocation(latitude: item['lat'], longitude:  item['lon'], address:  item['address']),
            image: File(item['image'])))
        .toList();
    notifyListeners();
  }
}
