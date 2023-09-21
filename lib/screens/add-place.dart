import 'dart:ffi';
import 'dart:io';

import 'package:camera/providers/user-places.dart';
import 'package:camera/widgets/image-input.dart';
import 'package:camera/widgets/location-input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final _titleController = TextEditingController();
  File? selectedImage;

  void saveplace() {
    final enteredTitle = _titleController.text;

    if (enteredTitle == null || enteredTitle.isEmpty || selectedImage == null) {
      return;
    }

    ref.read(userPlaceProvider.notifier).addPlace(enteredTitle, selectedImage!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: _titleController,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 26,
            ),
            ImageInput(
              onPickImage: (image) {
                selectedImage = image;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            LocationInput(),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: saveplace,
                label: const Text("Place qo'shish"))
          ],
        ),
      ),
    );
  }
}
