import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/navigation/page_navigation_bar.dart';
import 'package:flutter/material.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  static const String routeName = '/requests';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PageNavigationBar(
        currentIndex: 2,
      ), // Requests is index 2
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [Center(child: TextHeader('Requests Page'))]),
        ),
      ),
    );
  }
}
