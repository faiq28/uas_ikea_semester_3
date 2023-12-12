// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uts_ikea_semester_3/utility/defColor.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  int jumlah = 0;
  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 0.1,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Menu Akun",
                style: TextStyle(
                  color: primaryText,
                ),
              ),
              Icon(
                LucideIcons.settings,
                color: primaryText,
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset('assets/icons/Rectangle 44.png'),
                SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Faiq Afif A.',
                      style: TextStyle(
                        color: primaryText,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '160002359102020',
                      style: TextStyle(
                        color: secondText,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            bt(ScreenWidth),
            up(LucideIcons.userCircle2, 'Profil Saya'),
            bt(ScreenWidth),
            up(LucideIcons.package, 'Pesanan'),
            bt(ScreenWidth),
            up(LucideIcons.star, 'Ulasan'),
            bt(ScreenWidth),
            up(LucideIcons.gift, 'Reward Saya'),
            bt(ScreenWidth),
            up(LucideIcons.helpCircle, 'Bantuan'),
          ],
        ),
      ),
    );
  }

  Row up(IconData icons, String text) {
    return Row(
      children: [
        Icon(icons),
        SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: primaryText,
          ),
        )
      ],
    );
  }

  Container bt(double ScreenWidth) {
    return Container(
      margin: EdgeInsets.only(bottom: 24, top: 24),
      height: 0.8,
      width: ScreenWidth,
      color: Color(0xffE7E7E7),
    );
  }
}
