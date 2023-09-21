import 'dart:ffi';

import 'package:camera/models/place.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as goole;
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;
  var marker = <Marker>[];
  var isgettinglocation = false;
  var isgettinglocationmap = false;
  double langituda = 0;
  double lotituda = 0;

  void _getcurrentlocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    setState(() {
      isgettinglocation = true;
    });

    locationData = await location.getLocation();
 final lat = locationData.latitude;
    final long = locationData.longitude;

    if (lat == null || long == null) {
      return;
    }
    setState(() {

      pickedLocation=PlaceLocation(longituda: long, lalituda: lat, address: address)
      isgettinglocation = false;
    });

   

    setState(() {
      langituda = long;
      lotituda = lat;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewcontent = Text(
      "siz hali joylashuv tanlamadingiz ",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (isgettinglocation) {
      previewcontent = const CircularProgressIndicator();
    }

    if (lotituda != 0 && langituda != 0) {
      previewcontent = FlutterMap(
        options: MapOptions(
          center: LatLng(lotituda, langituda),
          zoom: 9.2,
        ),
        nonRotatedChildren: [
          RichAttributionWidget(
            attributions: [
              TextSourceAttribution('OpenStreetMap contributors', onTap: () {}),
            ],
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
        ],
      );
    }
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 130,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            ),
          ),
          child: previewcontent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getcurrentlocation,
              icon: const Icon(Icons.location_on),
              label: const Text("hozirgi joylashuv"),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.map),
              label: const Text(" joylashuv tanlash"),
            )
          ],
        )
      ],
    );
  }
}
