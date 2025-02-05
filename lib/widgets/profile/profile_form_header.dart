import 'package:barkcode/models/navigator_model.dart';
import 'package:barkcode/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class ProfileFormHeader extends StatelessWidget {
  const ProfileFormHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageWidget(
          asset: "assets/profile_form/header.jpg",
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
                  Navigator.pop(context, NavigatorModel(willRefresh: false));
                },
                icon: Icon(Icons.arrow_back_rounded)),
          ),
        )
      ],
    );
  }
}
