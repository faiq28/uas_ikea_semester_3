// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:uts_ikea_semester_3/components/prv/btnProvNavbar.dart';

import 'package:uts_ikea_semester_3/pages/inspirasi.dart';
import 'package:uts_ikea_semester_3/pages/profile.dart';
import 'package:uts_ikea_semester_3/pages/wishlist/wishlist.dart';
import 'package:uts_ikea_semester_3/utility/defColor.dart';

class BtmNav extends StatefulWidget {
  @override
  State<BtmNav> createState() => _BtmNavState();
}

class _BtmNavState extends State<BtmNav> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController(
        initialPage: context.read<NavigationProvider>().selectedIndex);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          // Halaman 1: Beranda
          // Home(),
          // Halaman 2: Inspirasi
          // InspirasiBody(),
          InspirasiBody(),
          // Halaman 3: Wishlist
          Wishlist(),
          // Halaman 4: Profil
          Profil()
        ],
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme:
            IconThemeData(color: Color(0xff1B1B1B).withOpacity(0.8)),
        unselectedLabelStyle: TextStyle(color: secondText),
        currentIndex: context.watch<NavigationProvider>().selectedIndex,
        selectedItemColor: primary,
        onTap: (index) {
          setState(() {
            context.read<NavigationProvider>().selectedIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              LucideIcons.home,
              size: 26,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.coffee, size: 26),
            label: 'Inspirasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.heart, size: 26),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Iconsax.profile_circle, size: 26),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
