import 'package:barkcode/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:time_machine/time_machine.dart';

class PetTile extends StatelessWidget {
  const PetTile({
    super.key,
    required this.pet,
  });

  final Pet pet;

  @override
  Widget build(BuildContext context) {
    var age =
        LocalDateTime.now().periodSince(LocalDateTime.dateTime(pet.birthday));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: const Color.fromARGB(255, 231, 251, 255),
        border: Border.all(
          color: Colors.blueAccent,
          width: 2.5,
        ),
      ),
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(2),
      height: 100,
      child: Row(
        children: [
          Container(
            width: 90.0,
            height: 90.0,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                image: NetworkImage(pet.images.profilePicture),
                fit: BoxFit.cover,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.blueAccent,
                width: 1,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    pet.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.cake_outlined),
                      Text(DateFormat('MMMM dd yyyy').format(pet.birthday),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  Text("${age.years} Years and ${age.months} Months Old",
                      overflow: TextOverflow.ellipsis),
                  Text(pet.breed, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
