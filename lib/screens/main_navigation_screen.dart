import 'package:flutter/material.dart';
import '../widgets/layout/bottom_nav_bar.dart';
import 'home/home_screen.dart';
import 'booking/select_package_screen.dart';
import 'appointment/appointment_screen.dart';
import 'profile/profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialTab;

  const MainNavigationScreen({
    super.key,
    this.initialTab = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTab;
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        onNavigateTab: _onTabChanged,
      ),
      const SelectPackageScreen(),
      const AppointmentScreen(showBottomNav: false),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabChanged,
      ),
    );
  }
}
