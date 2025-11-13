import 'package:ecobin/core/presentation/ui/widgets/text_styles.dart';
import 'package:ecobin/features/navigation/page_navigation_bar.dart';
import 'package:flutter/material.dart';

class Activities extends StatelessWidget {
  const Activities({super.key});

  static const String routeName = '/activities';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: PageNavigationBar(currentIndex: 1),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [Center(child: TextHeader('Activities Page'))],
          ),
        ),
      ),
    );
  }
}
