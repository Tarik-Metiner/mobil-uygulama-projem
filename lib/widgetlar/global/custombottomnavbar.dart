import 'package:flutter/material.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onItemTapped,

      type: BottomNavigationBarType.fixed,

      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          label: "Ana Sayfa",
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.restaurant,
          ),
          label: "Besinler",
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.fitness_center,
          ),
          label: "Egzersizler",
        ),

        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: "Profil",
        ),
      ],
    );
  }
}