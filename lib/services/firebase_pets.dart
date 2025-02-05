import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:barkcode/models/pet_model.dart';

class FirebasePetServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference pets =
      FirebaseFirestore.instance.collection('pets');

  final storage = FirebaseStorage.instance;

  Future<bool> updatePet({
    required Pet pet,
    List<XFile>? albumPicture,
    XFile? coverPicture,
    XFile? profilePicture,
  }) async {
    try {
      if (albumPicture != null) {
        pet.images.album.clear();
        for (var image in albumPicture) {
          pet.images.album.add(await uploadImageToStorage(image, pet.id));
        }
      }

      if (coverPicture != null) {
        pet.images.coverPicture =
            await uploadImageToStorage(coverPicture, pet.id);
      }

      if (profilePicture != null) {
        pet.images.profilePicture =
            await uploadImageToStorage(profilePicture, pet.id);
      }

      await pets.doc(pet.id).set(pet.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addPet(
      {required Pet pet,
      required List<XFile> albumPicture,
      required XFile coverPicture,
      required XFile profilePicture}) async {
    try {
      String id = pets.doc().id;
      pet.id = id;

      // TO-DO Optimize

      pet.images.profilePicture =
          await uploadImageToStorage(profilePicture, id);
      pet.images.coverPicture = await uploadImageToStorage(coverPicture, id);

      for (var image in albumPicture) {
        pet.images.album.add(await uploadImageToStorage(image, id));
      }

      var data = pet.toJson();

      await pets.doc(id).set(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImageToStorage(XFile file, String petId) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('pets/$petId')
          .child('/${file.name}');

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path},
      );

      // if (kIsWeb) {
      await ref.putData(await file.readAsBytes(), metadata);
      // } else {
      //   uploadTask = ref.putFile(io.File(file.path), metadata);
      // }
      return ref.getDownloadURL();
    } catch (e) {
      print(
          "Something went wrong (product_service.dart uploadImageToStorage Method): $e");
      return "";
    }
  }

  FutureOr<List<Pet>> getPets() async {
    final String userId = _auth.currentUser?.uid ?? "";
    if (userId == "") {
      return [];
    }
    var qSnapShot = await pets.where(Filter("userId", isEqualTo: userId)).get();

    return qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return Pet.fromJson(response as Map<String, dynamic>);
    }).toList();
  }

  FutureOr<Pet> getPetById({required String id}) async {
    var qSnapShot = await pets.doc(id).get();

    Object? response = qSnapShot.data();
    return Pet.fromJson(response as Map<String, dynamic>);
  }
}
