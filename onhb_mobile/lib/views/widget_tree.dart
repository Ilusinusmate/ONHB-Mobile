import 'package:flutter/material.dart';
import 'package:onhb_mobile/data/notifiers.dart';
import 'package:onhb_mobile/views/pages/home/home_page.dart';
import 'package:onhb_mobile/views/pages/questions/questions_page.dart';
import 'package:onhb_mobile/views/pages/results/results_page.dart';
import 'package:onhb_mobile/views/pages/teams/team_page.dart';
import 'package:onhb_mobile/widgets/bars/main_navigation_bar.dart';
import 'package:onhb_mobile/widgets/bars/main_app_bar.dart';
import 'package:onhb_mobile/widgets/drawers/main_drawer.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  // List of pages
  static final List<Widget> _pages = [
    Center(child: HomePage()),
    Center(child: QuestionsPage(numberOfQuestions: 10)),
    Center(child: ResultsPage()),
    Center(child: TeamPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotfier,
      builder: (context, value, child) {
        return Scaffold(
          appBar: MainAppBar(),
          body: _pages.elementAt(value),
          drawer: MainDrawer(),
          bottomNavigationBar: MainNavigationBar(),
        );
      },
    );
  }
}
