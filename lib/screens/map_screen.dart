import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jiokee/widgets/custom_app_bar.dart';

class MapView extends StatefulWidget {

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {

  // Initial location of the Map view
  CameraPosition _initialLocation = CameraPosition(target: LatLng(0.0, 0.0));

  // For controlling the view of the Map
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        appBar: CustomAppBar(
        title: 'Maps',
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
        body: Stack(
          children: <Widget>[
              GoogleMap(
              initialCameraPosition: _initialLocation,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
            ),

          ],
        ),
      ),
    );
  }
}