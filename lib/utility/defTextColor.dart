// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
import 'defColor.dart';

class TeksSemua extends StatelessWidget {
  const TeksSemua({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Text(
        'Lihat semua',
        style: TextStyle(
          color: primary,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }
}
