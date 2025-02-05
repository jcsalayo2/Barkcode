import 'package:barkcode/core/route/args/pet_profile_page_args.dart';
import 'package:barkcode/models/navigator_model.dart';
import 'package:barkcode/models/pet_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.width,
    this.pet,
    required this.refreshFunc,
    required this.willRefresh,
  });

  final double width;
  final Pet? pet;
  final Function({bool? willRefresh}) refreshFunc;
  final bool willRefresh;

  @override
  Widget build(BuildContext context) {
    bool isEditable = false;
    final FirebaseAuth auth = FirebaseAuth.instance;
    isEditable = (auth.currentUser?.uid ?? 1) == (pet?.userId ?? 2);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 3, color: Colors.blueAccent),
          )),
          child: pet == null
              ? SizedBox(
                  height: 200,
                )
              : Image.network(
                  pet?.images.coverPicture ?? "",
                  height: 200,
                  width: width,
                  fit: BoxFit.cover,
                ),
        ),
        Positioned(
          bottom: -70,
          left: 20,
          child: Container(
            width: 150.0,
            height: 150.0,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: NetworkImage(pet?.images.profilePicture ?? ""),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blueAccent,
                width: 3,
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: IconButton(
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(
                      context, NavigatorModel(willRefresh: willRefresh));
                },
                icon: Icon(Icons.arrow_back_rounded)),
          ),
        ),
        if (isEditable)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent,
              ),
              child: IconButton(
                  color: Colors.white,
                  onPressed: () async {
                    var willRefresh = await Navigator.pushNamed(
                        context, "/pet_form",
                        arguments: PetProfilePageArgs(pet: pet!));

                    if ((willRefresh as NavigatorModel).willRefresh ?? false) {
                      if ((willRefresh).mode == 'updatePet') {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 2),
                            content: Text("Update succesful")));
                      }

                      refreshFunc(willRefresh: true);
                    }
                  },
                  icon: Icon(Icons.edit)),
            ),
          )
      ],
    );
  }
}
