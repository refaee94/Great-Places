import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/helpers/location_helper.dart';
import 'package:flutter_complete_guide/screens/map_Screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectLocation;

  const LocationInput({Key key, this.onSelectLocation}) : super(key: key);

  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String imagePreview;
  Future<void> selectMap() async {
    final LatLng selectedLoacation = await Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => MapScreen(
                  isSelcted: true,
                )));

    if (selectedLoacation == null) {
      print(selectedLoacation.latitude.toString()+'---------------');
      return;
    }
    showPrev(selectedLoacation.latitude, selectedLoacation.longitude);

    widget.onSelectLocation(
        selectedLoacation.latitude, selectedLoacation.longitude);
  }

  Future<void> userLocation() async {
    try {
      final response = await Location().getLocation();
      showPrev(response.latitude, response.longitude);
      widget.onSelectLocation(response.latitude, response.longitude);
    } catch (e) {
      return;
    }
  }

  void showPrev(double lat, double lon) {
    final staticImage = LocationHelper.generatePrev(lat: lat, longt: lon);

    setState(() {
      imagePreview = staticImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: double.infinity,
        height: 170,
        child: imagePreview == null
            ? Text(
                'no Location chosen',
                textAlign: TextAlign.center,
              )
            : Image.network(
                imagePreview,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
        decoration:
            BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FlatButton.icon(
            onPressed: userLocation,
            icon: Icon(Icons.location_on),
            label: Text('Current Location'),
            textColor: Theme.of(context).primaryColor,
          ),
          FlatButton.icon(
              onPressed: selectMap,
              icon: Icon(Icons.map),
              textColor: Theme.of(context).primaryColor,
              label: Text('Choose Location from map'))
        ],
      )
    ]);
  }
}
