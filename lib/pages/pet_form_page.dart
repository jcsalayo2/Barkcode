import 'dart:typed_data';

import 'package:barkcode/core/route/args/pet_profile_page_args.dart';
import 'package:barkcode/models/navigator_model.dart';
import 'package:barkcode/models/pet_model.dart';
import 'package:barkcode/services/pet/pet_services.dart';
import 'package:barkcode/widgets/profile/profile_form_header.dart';
import 'package:barkcode/widgets/text_field_pet.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileFormPage extends StatefulWidget {
  const ProfileFormPage({super.key});

  @override
  State<ProfileFormPage> createState() => _ProfileFormPageState();
}

class _ProfileFormPageState extends State<ProfileFormPage> {
  var nameController = TextEditingController();
  var genderController = TextEditingController();
  DateTime? birthday;
  var breedController = TextEditingController();
  var contactController = TextEditingController();
  XFile? profilePicture;
  Uint8List? profilePictureAsByte;
  XFile? coverPicture;
  Uint8List? bannerPictureAsByte;
  List<XFile> albumPicture = [];
  List<Uint8List> albumPictureAsByte = [];
  bool isLoading = false;
  bool isFirstLoad = true;
  bool isUpdate = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments == null
        ? null
        : ModalRoute.of(context)!.settings.arguments as PetProfilePageArgs;

    if (args != null && isFirstLoad) {
      isUpdate = true;
      isFirstLoad = false;
      nameController.text = args.pet.name;
      genderController.text = args.pet.gender;
      breedController.text = args.pet.breed;
      contactController.text = args.pet.contact;
      birthday = args.pet.birthday;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileFormHeader(),
              Text(
                "Pet Information",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),
              TextFieldPetWidget(controller: nameController, hintText: "Name"),
              SizedBox(height: 10),
              TextFieldPetWidget(
                  controller: genderController, hintText: "Gender"),
              SizedBox(height: 10),
              birthdayWidget(initialValue: args?.pet.birthday),
              SizedBox(height: 10),
              TextFieldPetWidget(
                  controller: breedController, hintText: "Breed"),
              SizedBox(height: 10),
              TextFieldPetWidget(
                  controller: contactController, hintText: "Contact"),
              SizedBox(height: 10),
              Text(
                "Profile Photo",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue),
                onPressed: () async {
                  var file = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                  );

                  if (file == null) {
                    return;
                  }

                  profilePictureAsByte = await file.readAsBytes();
                  setState(() {
                    profilePicture = file;
                  });
                },
                child: const Text('Pick Image'),
              ),
              if (profilePictureAsByte != null)
                Image.memory(
                  height: 125,
                  profilePictureAsByte!,
                  fit: BoxFit.contain,
                ),
              Text(
                "Cover Photo",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              TextButton(
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue),
                onPressed: () async {
                  var file = await ImagePicker()
                      .pickImage(source: ImageSource.gallery, imageQuality: 50);

                  if (file == null) {
                    return;
                  }

                  bannerPictureAsByte = await file.readAsBytes();
                  setState(() {
                    coverPicture = file;
                  });
                },
                child: const Text('Pick Image'),
              ),
              if (bannerPictureAsByte != null)
                Image.memory(
                  height: 125,
                  bannerPictureAsByte!,
                  fit: BoxFit.contain,
                ),
              Text(
                "Album Photos",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  onPressed: () async {
                    var files = await ImagePicker()
                        .pickMultiImage(limit: 12, imageQuality: 50);

                    if (files.isEmpty) {
                      return;
                    } else if (files.length > 10) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("You can only choose 12 images"),
                      ));
                      return;
                    }

                    for (var image in files) {
                      albumPictureAsByte.add(await image.readAsBytes());
                    }
                    setState(() {
                      albumPicture = files;
                    });
                  },
                  child: const Text('Pick Images (Max of 12)')),
              if (albumPictureAsByte.isNotEmpty)
                GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: albumPictureAsByte.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Image.memory(
                        albumPictureAsByte[index],
                        fit: BoxFit.contain,
                      );
                    }),
              const SizedBox(height: 10),
              TextButton(
                onPressed: isLoading
                    ? null
                    : isUpdate
                        ? () async {
                            if (nameController.text.trim() == '' ||
                                birthday == null ||
                                contactController.text.trim() == '' ||
                                breedController.text.trim() == '' ||
                                genderController.text.trim() == '') {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Complete the form to continue"),
                              ));
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });

                            var isSuccess = await PetServices().updatePet(
                              name: nameController.text.trim(),
                              birthday: birthday!,
                              contact: contactController.text.trim(),
                              gender: genderController.text.trim(),
                              profilePicture: profilePicture,
                              coverPicture: coverPicture,
                              albumPicture:
                                  albumPicture.isEmpty ? null : albumPicture,
                              breed: breedController.text.trim(),
                              oldPet: args!.pet,
                            );
                            if (isSuccess) {
                              Navigator.pop(
                                  context,
                                  NavigatorModel(
                                      mode: 'updatePet', willRefresh: true));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        : () async {
                            if (nameController.text.trim() == '' ||
                                birthday == null ||
                                contactController.text.trim() == '' ||
                                genderController.text.trim() == '' ||
                                breedController.text.trim() == '' ||
                                profilePicture == null ||
                                coverPicture == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Complete the form to continue"),
                              ));
                              return;
                            }
                            setState(() {
                              isLoading = true;
                            });
                            var isSuccess = await PetServices().addPet(
                              name: nameController.text.trim(),
                              birthday: birthday!,
                              contact: contactController.text.trim(),
                              gender: genderController.text.trim(),
                              profilePicture: profilePicture!,
                              coverPicture: coverPicture!,
                              albumPicture: albumPicture,
                              breed: breedController.text.trim(),
                            );
                            if (isSuccess) {
                              Navigator.pop(
                                  context,
                                  NavigatorModel(
                                      mode: 'addPet', willRefresh: true));
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue),
                child: isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "Save",
                        style: TextStyle(fontSize: 24),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DateTimeFormField birthdayWidget({required DateTime? initialValue}) {
    return DateTimeFormField(
      mode: DateTimeFieldPickerMode.date,
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.cake),
        labelText: 'Birthday',
        filled: true,
        fillColor: const Color.fromARGB(255, 233, 233, 233),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.blueAccent)),
      ),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 40)),
      initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
      onChanged: (DateTime? value) {
        birthday = value;
      },
    );
  }
}
