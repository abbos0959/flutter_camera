import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(
      {required this.longituda, required this.lalituda, required this.address});

  final double lalituda;
  final double longituda;
  final String address;
}

class Place {
  Place({
    required this.title,
    required this.image,
    // required this.location
  }) : id = uuid.v4();
  final String id;
  final String title;
  final File image;
  // final PlaceLocation location;
}
