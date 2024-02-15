import 'dart:async';
import 'package:flutter/Material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_places/Models/place_model.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../Utilies/Shared/constants.dart';


class MapScreen extends StatefulWidget {

  final PlaceLocation location;
  const MapScreen({required this.location,Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  bool isGo = false;



  Completer<GoogleMapController> _controller = Completer();
  LocationData source = myLocationData!;
  LocationData? currentLocation = myLocationData;
  
  List<LatLng> polylineCoordinates = [];

  void getCurrentLiveLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
        currentLocation = location;
    });
      GoogleMapController googleMapController = await _controller.future;

          location.onLocationChanged.listen((LocationData newLocation) {
              setState(() {
                currentLocation = newLocation;
              });
            googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(newLocation.latitude!, newLocation.longitude!),
                  zoom: 20,
                ),
              ),
            );
          });
  }


  // this method will generate a route between the two locations
  void getPolyPoints() async {
    PolylinePoints polyLinePoints = PolylinePoints();
    PolylineResult result = await polyLinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(source.latitude!,source.longitude!),
      PointLatLng(widget.location.latitude,widget.location.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {

      });

    }
  }

@override
  void initState() {
    getCurrentLiveLocation();
    getPolyPoints();
    super.initState();
  }


  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      body: currentLocation == null ?
      const Center(child: CircularProgressIndicator()) :
      Stack(
          children: [
            GoogleMap(
              // this function is called every time the location changes to update the map camera position
                onMapCreated: (GoogleMapController controller) {
                  if(!_controller.isCompleted){
                    setState(() {
                      _controller.complete(controller);
                    }
                    );
                  }
                },

                // this is the list of polylines that will be drawn on the map to show the route between source and destination locations
                polylines:{
                  Polyline(
                    polylineId: const PolylineId('rouete'),
                    color: Colors.red,
                    points: polylineCoordinates,
                    width: 5,
                  ),
                },

                // it is the initial camera position of the map
                initialCameraPosition: CameraPosition(
                  target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
                  zoom: 14.4746,
                ),




                // this is the list of markers that will be drawn on the map to show the source and destination locations
                markers: {
                  // Source Marker
                  Marker(
                    markerId: const MarkerId('source'),
                    position: LatLng(source.latitude!,source.longitude!),
                  ) ,


                  // Current Location Marker
                  Marker(
                    markerId: const MarkerId('current'),
                    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                    position: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
                  ) ,


                  // Destination Marker
                  Marker(
                    markerId: const MarkerId('destination'),
                    position: LatLng(widget.location.latitude,widget.location.longitude),
                  ),
                }
            ),
            // button to turn on live location
          ]
      ),
    );
  }
  @override
  void dispose() {
    _controller = Completer();
    super.dispose();
  }
}
