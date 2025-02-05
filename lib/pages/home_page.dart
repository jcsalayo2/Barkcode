import 'package:barkcode/core/route/args/pet_profile_page_args.dart';
import 'package:barkcode/models/navigator_model.dart';
import 'package:barkcode/models/pet_model.dart';
import 'package:barkcode/models/user_model.dart';
import 'package:barkcode/services/firebase_auth.dart';
import 'package:barkcode/services/pet/pet_services.dart';
import 'package:barkcode/widgets/home/pet_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pet> pets = [];
  UserFirebase? userFirebase;
  @override
  void initState() {
    getPets();
    getAccount();
    // TODO: implement initState
    super.initState();
  }

  getPets() async {
    var result = await PetServices().getPets();
    setState(() {
      pets = result;
    });
  }

  getAccount() async {
    var result = await FirebaseAuthService(FirebaseAuth.instance).getName();
    setState(() {
      userFirebase = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          var willRefresh = await Navigator.pushNamed(context, "/pet_form");
          if ((willRefresh as NavigatorModel).willRefresh ?? false) {
            if ((willRefresh).mode == 'addPet') {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.blue,
                  duration: Duration(seconds: 2),
                  content: Text("Create succesful")));
            }
            getPets();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userFirebase?.name ?? "",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('My Pets'),
              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () async {
                    var willRefresh = await Navigator.pushNamed(
                        context, "/profile/${pets[index].id}",
                        arguments: PetProfilePageArgs(pet: pets[index]));
                    if ((willRefresh as NavigatorModel).willRefresh ?? false) {
                      getPets();
                    }
                  },
                  child: PetTile(pet: pets[index]),
                ),
                itemCount: pets.length,
              )
            ],
          ),
        ),
      ),
    );
  }
}
