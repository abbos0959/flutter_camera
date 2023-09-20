import 'package:camera/providers/user-places.dart';
import 'package:camera/screens/add-place.dart';
import 'package:camera/widgets/place-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userplace = ref.watch(userPlaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("bu placeList"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AddPlace(),
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: PlaceList(places: userplace),
    );
  }
}
