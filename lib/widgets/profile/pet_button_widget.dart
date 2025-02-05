import 'package:flutter/material.dart';

class PetButtonWidget extends StatefulWidget {
  const PetButtonWidget({
    super.key,
  });

  @override
  State<PetButtonWidget> createState() => _PetButtonWidgetState();
}


class _PetButtonWidgetState extends State<PetButtonWidget> {
  var petCount = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton.filled(
            onPressed: () {
              setState(() {
                petCount++;
              });
            },
            icon: Icon(Icons.waving_hand_outlined)),
        Text("Pet Me!"),
        Text("Count: $petCount"),
      ],
    );
  }
}
