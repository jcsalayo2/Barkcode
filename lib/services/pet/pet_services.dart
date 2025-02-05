import 'dart:async';

import 'package:barkcode/models/pet_model.dart';
import 'package:barkcode/services/firebase_pets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:image_picker/image_picker.dart';

class PetServices {
  Future<bool> addPet({
    required String name,
    required DateTime birthday,
    required String gender,
    required String contact,
    required List<XFile> albumPicture,
    required XFile coverPicture,
    required XFile profilePicture,
    required String breed,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    var pet = Pet(
        name: name,
        birthday: birthday,
        gender: gender,
        contact: contact,
        petCount: 0,
        id: '',
        breed: breed,
        userId: auth.currentUser?.uid ?? '',
        images: Images(coverPicture: '', profilePicture: '', album: []));
    var result = await FirebasePetServices().addPet(
      pet: pet,
      albumPicture: albumPicture,
      coverPicture: coverPicture,
      profilePicture: profilePicture,
    );
    return result;
  }

  Future<bool> updatePet({
    required String name,
    required DateTime birthday,
    required String gender,
    required String contact,
    required List<XFile>? albumPicture,
    required XFile? coverPicture,
    required XFile? profilePicture,
    required String breed,
    required Pet oldPet,
  }) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    var pet = Pet(
        name: name,
        birthday: birthday,
        gender: gender,
        contact: contact,
        petCount: oldPet.petCount,
        id: oldPet.id,
        breed: breed,
        userId: auth.currentUser?.uid ?? '',
        images: oldPet.images);
    var result = await FirebasePetServices().updatePet(
      pet: pet,
      albumPicture: albumPicture,
      coverPicture: coverPicture,
      profilePicture: profilePicture,
    );
    return result;
  }

  FutureOr<List<Pet>> getPets() {
    return FirebasePetServices().getPets();
  }

  FutureOr<Pet> getPetById({required String id}) {
    return FirebasePetServices().getPetById(id: id);
  }
}
