import 'package:barkcode/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/time_machine.dart';
import 'package:intl/intl.dart';

class ProfileBasicInfo extends StatelessWidget {
  const ProfileBasicInfo({
    super.key,
    this.pet,
  });
  final Pet? pet;

  @override
  Widget build(BuildContext context) {
    var age = LocalDateTime.now()
        .periodSince(LocalDateTime.dateTime(pet?.birthday ?? DateTime.now()));
    return Column(
      children: [
        Text(
          pet?.name ?? "",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cake_outlined),
            Text(
                DateFormat('MMMM dd yyyy')
                    .format(pet?.birthday ?? DateTime.now()),
                textAlign: TextAlign.center),
          ],
        ),
        Text("${age.years} Years and ${age.months} Months Old",
            textAlign: TextAlign.center),
        Text(pet?.breed ?? "", textAlign: TextAlign.center),
      ],
    );
  }
}
