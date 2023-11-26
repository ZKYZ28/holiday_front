import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:holiday_mobile/presentation/widgets/common/progress_loading_widget.dart';
import 'package:location/location.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng destination = LatLng(50.4735, 5.6758); // REMPLACER LOCATION ACTIVITE

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  Future<void> getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((location) {
      currentLocation = location;
      setState(() {});
    });
    // Bien le mettre après le location.getLocation()
    GoogleMapController googleMapController = await _controller.future;


    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;

      googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 13.5,
                target: LatLng(
                    newLoc.latitude!,
                    newLoc.longitude!))
          )
      );
      getPolyPoints();
      setState(() {});
    });
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDIE6IRIvdtr9OBehphohaLyT_TNQ-ltZE",
      PointLatLng(currentLocation!.latitude! , currentLocation!.longitude!),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      // clear les anciens points
      polylineCoordinates.clear();
      for (var point in result.points) {
        (polylineCoordinates.add(LatLng(point.latitude, point.longitude)));
      }
    }
    setState(() {});
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/images/flag.png").then((icon) => destinationIcon = icon);
  }

  @override
  void initState() {
    getCurrentLocation();
    setCustomMarkerIcon();
    getPolyPoints();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MAP')),
      body: currentLocation == null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [LoadingProgressor(), Text("Loading")],
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  zoom: 14),
              polylines: {
                Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                    color: Colors.purpleAccent,
                    width: 6),
              },
              markers: {
                Marker(
                  markerId: const MarkerId("source"),
                  //  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                  // position : source,
                ),
                 Marker(
                    markerId: MarkerId("destination"),
                    icon: destinationIcon,
                    position: destination
                ),
              },
              onMapCreated: (mapController) {
                _controller.complete(mapController);
              },
            ),
    );
  }
}
