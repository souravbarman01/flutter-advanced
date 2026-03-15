import 'package:flutter/material.dart';

import '../../menu/screens/menu_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/home_content.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _handleBottomNavTap(int index) {
    if (index == 3) {
      MenuScreen.show(context);
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeContent(
        selectedIndex: _selectedIndex,
        onTap: _handleBottomNavTap,
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _handleBottomNavTap,
      ),
    );
  }
}
