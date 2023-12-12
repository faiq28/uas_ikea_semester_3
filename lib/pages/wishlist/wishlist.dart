import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:uts_ikea_semester_3/components/flushBar.dart';
import 'model/wishlistModel.dart';
import 'package:uts_ikea_semester_3/utility/defColor.dart';
import 'package:uts_ikea_semester_3/pages/keranjang.dart';


class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  final TextEditingController searchController = TextEditingController();

  List<WishlistItem> wishlistItems = [];
  List<WishlistItem> displayItems = [];

  @override
  void initState() {
    super.initState();
    wishlistItems =
        Provider.of<WishlistModel>(context, listen: false).wishlistItems;
    displayItems = List.of(wishlistItems);
  }

  void filterItems(String value) {
    setState(() {
      displayItems = wishlistItems
          .where((element) =>
              element.text.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  bool closure = true;

  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 1.2,
        toolbarHeight: 80,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "WishList",
                  style: TextStyle(
                    color: primaryText,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      LucideIcons.search,
                      color: primaryText,
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) {
                  filterItems(value);
                },
                decoration: InputDecoration(
                  hintText: 'Cari barang impianmu',
                  prefixIcon: Icon(Icons.search),
                  fillColor: Colors.grey.shade200,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        wishlistItems.length.toString(),
                        style: TextStyle(
                          color: primaryText,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        ' barang',
                        style: TextStyle(
                          color: secondText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Icon(LucideIcons.list)
                ],
              ),
              Container(
                width: screenWidth,
                height: 800,
                child: displayItems.isEmpty
                    ? SizedBox()
                    : ListView.builder(
                        itemCount: displayItems.length,
                        itemBuilder: (context, index) {
                          WishlistItem item = displayItems[index];

                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 24),
                            height: 155,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(item.img,
                                        width: 99, height: 99),
                                    SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: screenWidth / 1.5,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                item.text,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: primaryText,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    closure = !closure;
                                                  });
                                                },
                                                child: Icon(Icons.more_vert),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        Container(
                                          width: 155,
                                          child: Text(
                                            item.subtext,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: secondText,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'id_ID',
                                                  symbol: 'Rp.',
                                                  decimalDigits: 0)
                                              .format(item.harga)
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: primaryText,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Consumer<CartProvider>(
                                          builder:
                                              (context, cartProvider, child) {
                                            return ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shadowColor: Colors.white,
                                                primary: Colors
                                                    .white, // Background color
                                                side: BorderSide(
                                                    color:
                                                        primary), // Border color
                                              ),
                                              onPressed: () {
                                                cartProvider.addToCart(
                                                  Product(
                                                    image: item.img,
                                                    text: item.text,
                                                    subtext: item.subtext,
                                                    harga: item.harga,
                                                  ),
                                                );
                                                print('Item added to cart');
                                                NotificationUtils
                                                    .showNotification(
                                                  context,
                                                  'Item ditambahkan ke Keranjang',
                                                );
                                              },
                                              child: Container(
                                                width: screenWidth / 1.7,
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Tambah Keranjang',
                                                    style: TextStyle(
                                                      color: primary,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
