import 'package:barkcode/core/route/args/pet_profile_page_args.dart';
import 'package:barkcode/models/pet_model.dart';
import 'package:barkcode/services/pet/pet_services.dart';
import 'package:barkcode/widgets/profile/pet_button_widget.dart';
import 'package:barkcode/widgets/profile/profile_basic_info.dart';
import 'package:barkcode/widgets/profile/profile_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PetProfilePage extends StatefulWidget {
  const PetProfilePage({super.key, required this.id});

  final String id;

  @override
  State<PetProfilePage> createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  bool willRefresh = false;
  Pet? pet;
  @override
  void initState() {
    getPetById();
    // TODO: implement initState
    super.initState();
  }

  getPetById({bool? willRefresh}) async {
    var result = await PetServices().getPetById(id: widget.id);
    setState(() {
      pet = result;
      this.willRefresh = willRefresh ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileHeader(width: width, pet: pet, refreshFunc: getPetById, willRefresh:willRefresh),
            SizedBox(height: 15),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 18, top: 30),
                  width: 150,
                  child: PetButtonWidget(),
                ),
                Expanded(child: ProfileBasicInfo(pet: pet)),
              ],
            ),
            Container(
              color: Colors.blueAccent,
              child: Text(
                "Album",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => Align(
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(pet?.images.album[index] ?? ""))),
                    margin: EdgeInsets.all(5),
                    height: 95,
                    width: 95,
                  ),
                ),
                itemCount: pet?.images.album.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
