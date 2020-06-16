import '../models/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation initLocation;
  final bool isSelcted;

  const MapScreen(
      {this.initLocation =
          const PlaceLocation(latitude: 25.323096, longitude: 55.388652),
      this.isSelcted = false});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng pickedPostion;
  void selectLocation(LatLng postion) {
    setState(() {
      pickedPostion = postion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          actions: <Widget>[
            if (widget.isSelcted)
              IconButton(
                icon: Icon(Icons.check),
                onPressed: pickedPostion == null
                    ? null
                    : () {
                        Navigator.pop(context, pickedPostion);
                      },
              )
          ],
        ),
        body: GoogleMap(
          onTap: widget.isSelcted ? selectLocation : null,
          markers:( pickedPostion == null&& widget.isSelcted)
              ? null
              : {Marker(markerId: MarkerId('m'), position: pickedPostion??LatLng(
                  widget.initLocation.latitude, widget.initLocation.longitude),
              )},
          initialCameraPosition: CameraPosition(
              target: LatLng(
                  widget.initLocation.latitude, widget.initLocation.longitude),
              zoom: 16),
        ));
  }
}
