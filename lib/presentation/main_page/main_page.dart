import 'package:flutter/material.dart';
import 'package:petmaama/presentation/home_screen.dart';
import 'package:petmaama/presentation/main_page/bottom_tab_bar.dart';
import 'package:petmaama/presentation/profile/profile_page.dart';
import 'package:petmaama/presentation/service_page.dart';
import 'package:petmaama/presentation/store_page.dart';


class MainPageScreen extends StatelessWidget {
  MainPageScreen({super.key});
  final List pages = [
    const HomeScreen(),
    const ServicePage(),
    const StorePage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: bottomNavigationNotifier,
          builder: (context, int index, child) {
            return pages[index];
          },
        ),
        bottomNavigationBar: const BottomNavigationWidget(),
      ),
    );
  }
}
