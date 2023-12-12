// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:uts_ikea_semester_3/components/buttonNav.dart';

class WishlistDefault extends StatefulWidget {
  const WishlistDefault({super.key});

  @override
  State<WishlistDefault> createState() => _WishlistDefaultState();
}

class _WishlistDefaultState extends State<WishlistDefault> {
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BtmNav(),
    );
  }
}
