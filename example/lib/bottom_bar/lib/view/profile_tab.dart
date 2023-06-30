import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "About",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const Icon(
          IconlyLight.profile,
          size: 40,
        ),
      ],
    );
  }
}
