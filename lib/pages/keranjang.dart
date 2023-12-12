import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:uts_ikea_semester_3/components/flushBar.dart';
import 'package:uts_ikea_semester_3/components/prv/btnProvNavbar.dart';
import 'package:uts_ikea_semester_3/utility/defColor.dart';
import 'package:uts_ikea_semester_3/pages/wishlist/defWishlist.dart';
// import 'model/keranjangModel.dart';
class Keranjang extends StatefulWidget {
  @override
  State<Keranjang> createState() => _KeranjangState();
}

class _KeranjangState extends State<Keranjang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: white,
        elevation: 1.2,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(LucideIcons.arrowLeft, color: primaryText),
                ),
                SizedBox(width: 16),
                Text(
                  "Keranjang",
                  style: TextStyle(
                    color: primaryText,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WishlistDefault();
                    },
                  ),
                );
                context.read<NavigationProvider>().selectedIndex = 2;
              },
              child: Icon(
                Icons.favorite_border_outlined,
                color: primaryText,
                size: 26,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
                child: Column(
                  children: [
                    Consumer<CartProvider>(
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    value.cartItems.length.toString(),
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
                              Consumer<CartProvider>(
                                builder: (context, value, child) {
                                  return GestureDetector(
                                    onTap: () {
                                      value.removeBulkFromCart();
                                    },
                                    child: Text(
                                      'Hapus semua',
                                      style: TextStyle(
                                        color: primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Consumer<CartProvider>(
                        builder: (context, cartProvider, child) {
                          final screenWidth = MediaQuery.of(context).size.width;

                          return _Isi(screenWidth, cartProvider);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                List<Product> cartItems = cartProvider.cartItems;

                // Hitung total
                double total = cartItems.fold(0, (previousValue, product) {
                  return previousValue + (product.harga * product.jumlah);
                });
                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffE7E7E7),
                    ),
                  ),
                  padding: EdgeInsets.all(24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(color: secondText),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id_ID',
                                      symbol: 'Rp.',
                                      decimalDigits: 0)
                                  .format(total)
                                  .toString(),
                              style: TextStyle(
                                color: primaryText,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          NotificationUtils.showNotification(
                            context,
                            'Item dibeli',
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 76, vertical: 18),
                          color: primary,
                          child: Text(
                            'Beli',
                            style: TextStyle(
                              color: white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Container _Isi(double screenWidth, CartProvider cartProvider) {
    return Container(
      width: screenWidth,
      height: 600,
      child: ListView.builder(
        itemCount: cartProvider.cartItems.length,
        itemBuilder: (context, index) {
          var product = cartProvider.cartItems[index];
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
                    Image.asset(product.image, width: 99, height: 99),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: screenWidth / 1.6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                product.text,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: primaryText,
                                ),
                              ),
                              Icon(Icons.more_vert)
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Container(
                          width: 155,
                          child: Text(
                            product.subtext,
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
                              .format(product.harga * product.jumlah)
                              .toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: primaryText,
                          ),
                        ),
                        SizedBox(height: 12),
                        Consumer<CartProvider>(
                          builder: (context, value, child) {
                            return Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 9,
                                    horizontal: 26,
                                  ),
                                  // width: ,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffE7E7E7),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      cartProvider.removeFromCart(product);
                                    },
                                    child: Center(
                                      child: Icon(
                                        LucideIcons.trash2,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 9,
                                    horizontal: 12,
                                  ),
                                  // width: ,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color(0xffE7E7E7),
                                    ),
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (product.jumlah > 0) {
                                                product.jumlah--;
                                              }
                                            });
                                          },
                                          child: Icon(
                                            LucideIcons.minus,
                                            size: 20,
                                            color: product.jumlah > 0
                                                ? primary
                                                : Color(0xffB4B4B4),
                                          ),
                                        ),
                                        SizedBox(width: 48),
                                        Text(product.jumlah.toString()),
                                        SizedBox(width: 48),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              product.jumlah++;
                                            });
                                          },
                                          child: Icon(
                                            LucideIcons.plus,
                                            size: 20,
                                            color: primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
    );
  }
}


class Product {
  String image;
  String text;
  String subtext;
  int harga;
  int jumlah;

  Product({
    required this.image,
    required this.text,
    required this.subtext,
    required this.harga,
    this.jumlah = 1,
  });
}

class CartProvider extends ChangeNotifier {
  List<Product> _cartItems = [];
  int _jumlah = 1;

  List<Product> get cartItems => _cartItems;
  int get jumlah => _jumlah;

  void addToCart(Product product) {
    bool productExists = false;

    for (Product cartProduct in _cartItems) {
      if (cartProduct.text == product.text) {
        cartProduct.jumlah += product.jumlah;
        productExists = true;
        break;
      }
    }

    if (!productExists) {
      _cartItems.add(product);
    }

    notifyListeners();
    _jumlah = 0;
  }

  void resetJumlah() {
    _jumlah = 0;
    notifyListeners();
  }

  void removeBulkFromCart() {
    _cartItems.clear();
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void tambah() {
    _jumlah++;
    notifyListeners();
  }

  void kurang() {
    if (_jumlah > 0) {
      _jumlah--;
      notifyListeners();
    }
  }
}

