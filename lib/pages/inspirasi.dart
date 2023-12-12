
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:uts_ikea_semester_3/utility/defColor.dart';
import 'package:uts_ikea_semester_3/pages/keranjang.dart';

class InspirasiBody extends StatefulWidget {
  const InspirasiBody({super.key});

  @override
  State<InspirasiBody> createState() => _InspirasiBodyState();
}

class _InspirasiBodyState extends State<InspirasiBody> {
  @override
  int selcetindex = 0;
  bool drawer = false;

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Jumlah halaman dalam tab
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          elevation: 1.2,
          toolbarHeight: 80,
          automaticallyImplyLeading: false,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Temukan Inspirasi",
                    style: TextStyle(
                      color: primaryText,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            drawer = !drawer;
                          });
                        },
                        child: Icon(
                          LucideIcons.search,
                          color: primaryText,
                        ),
                      ),
                      SizedBox(width: 24),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Keranjang();
                            },
                          ));
                        },
                        child: Icon(
                          LucideIcons.shoppingCart,
                          color: primaryText,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              drawer ? Text('true') : Text('false'),
            ],
          ),
          bottom: TabBar(
            padding: EdgeInsets.only(right: 132),
            indicatorPadding: EdgeInsets.symmetric(horizontal: 18),
            indicatorWeight: 3,
            indicatorColor: primary,
            labelColor: primaryText,
            unselectedLabelColor: secondText,
            labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            unselectedLabelStyle:
                TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            tabs: [
              Tab(
                text: 'Inspirasi',
              ),
              Tab(
                text: 'Koleksi',
              ),
              Tab(
                text: 'Edukasi',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Isi dari halaman 1
            InspirasiHalaman(),
            // Isi dari halaman 2
            Center(
              child: Text('Halaman Koeksi'),
            ),
            // Isi dari halaman 3
            Center(
              child: Text('Halaman Edukasi'),
            ),
          ],
        ),
      ),
    );
  }
}

class InspirasiHalaman extends StatefulWidget {
  const InspirasiHalaman({super.key});

  @override
  State<InspirasiHalaman> createState() => _InspirasiHalamanState();
}

class _InspirasiHalamanState extends State<InspirasiHalaman> {
  @override
  int selcetindex = 0;

  Widget build(BuildContext context) {
    final screenWitdh = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _Option(0, 'semua'),
                    SizedBox(width: 16),
                    _Option(1, 'Ruang Kerja'),
                    SizedBox(width: 16),
                    _Option(2, 'Dapur'),
                    SizedBox(width: 16),
                    _Option(3, 'Ruang Keluarga'),
                    SizedBox(width: 16),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _container1(
                    context,
                    'assets/images/Rectangle 34.png',
                    'Hunian compact yang nyaman dan bebas',
                  ),
                  SizedBox(width: 16),
                  _container1(
                    context,
                    'assets/images/Rectangle 33.png',
                    'Lakukan 5 hal ini agar sepatumu bebas ...',
                  ),
                ],
              ),
              SizedBox(height: 24),
              Column(
                children: [
                  Image.asset(
                    'assets/images/Rectangle 40.png',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Hadirkan nuasa elegant dan fancy kedalam kamar tidur anda',
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _container1(
                    context,
                    'assets/images/Rectangle 42.png',
                    'Rumah lebih sehat dengan set tempat',
                  ),
                  SizedBox(width: 16),
                  _container1(
                    context,
                    'assets/images/Rectangle 41.png',
                    'Membuat kamar anak rapi jadi lebih mudah',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _container1(BuildContext context, String img, String text) {
    final screenWitdh = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 24),
      height: 180,
      // color: primary,
      width: screenWitdh / 2.37,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            img,
            fit: BoxFit.cover,
            // width: screenWitdh / 2,
            // height: 120,
          ),
          SizedBox(height: 16),
          Text(
            text,
            style: TextStyle(
              color: primaryText,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }

  Widget _Option(int index, String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selcetindex =
              index; // Anda perlu menggunakan widget's state selcetindex
        });
      },
      child: Container(
        height: 48,
        padding: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: selcetindex == index ? primary : Colors.white,
          border: Border.all(
            width: 1,
            color: selcetindex == index
                ? primary
                : const Color.fromARGB(232, 224, 224, 224),
          ),
        ),
        child: Center(
          child: Text(
            text, // Tidak perlu menggunakan toString()
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: selcetindex == index ? white : primaryText,
            ),
          ),
        ),
      ),
    );
  }
}
