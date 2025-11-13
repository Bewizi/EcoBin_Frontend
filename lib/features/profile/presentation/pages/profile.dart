import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/navigation/page_navigation_bar.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  static const String routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PageNavigationBar(currentIndex: 3),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [Center(child: TextHeader('Profile Page'))]),
        ),
      ),
    );
  }
}
