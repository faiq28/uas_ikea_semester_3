
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:uts_ikea_semester_3/components/flushBar.dart';
import 'package:uts_ikea_semester_3/pages/keranjang.dart';
import 'package:uts_ikea_semester_3/pages/wishlist/model/wishlistModel.dart';
import 'package:uts_ikea_semester_3/utility/defColor.dart';
class Detail extends StatefulWidget {
  final String images;
  final String text;
  final String subText;
  final int harga;

  Detail(
      {required this.images,
      required this.text,
      required this.harga,
      required this.subText});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int jumlah = 0;
  @override
  bool isWish = false;
  Widget build(BuildContext context) {
    final screenWitdh = MediaQuery.of(context).size.width;

    final images = widget.images;
    final text = widget.text;
    final subtText = widget.subText;
    final harga = widget.harga;

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 1.2,
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    LucideIcons.arrowLeft,
                    color: primaryText,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  text,
                  style: TextStyle(
                    color: primaryText,
                  ),
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    LucideIcons.search,
                    color: primaryText,
                  ),
                ),
                SizedBox(width: 24),
                Icon(
                  LucideIcons.share,
                  color: primaryText,
                ),
                SizedBox(width: 24),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
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
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Image.asset('assets/images/Rectangle 23.png', fit: BoxFit.cover),
              SizedBox(height: 16),
              itemScroll(images),
              SizedBox(height: 24),
              detailProduct(text, images, subtText, harga),
              SizedBox(height: 24),
              _TambahKeranjnang(harga, images, text, subtText)
            ],
          ),
        ),
      ),
    );
  }

  Consumer<CartProvider> _TambahKeranjnang(
      int harga, String img, String text, String subText) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // width: 130,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Color(0xffE7E7E7)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      cartProvider.kurang();
                    },
                    child: Icon(
                      LucideIcons.minus,
                      color:
                          cartProvider.jumlah > 0 ? primary : Color(0xffB4B4B4),
                      size: 26,
                    ),
                  ),
                  SizedBox(width: 22),
                  Text(cartProvider.jumlah.toString()),
                  SizedBox(width: 22),
                  GestureDetector(
                    onTap: () {
                      cartProvider.tambah();
                    },
                    child: Icon(
                      LucideIcons.plus,
                      color: primary,
                      size: 26,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (cartProvider.jumlah == 0) {
                  NotificationUtils.showNotification(
                    context,
                    'Barang minimal harus 1',
                  );
                } else {
                  cartProvider.addToCart(
                    Product(
                      image: img,
                      text: text,
                      subtext: subText,
                      harga: harga,
                      jumlah: cartProvider.jumlah,
                    ),
                  );
                  NotificationUtils.showNotification(
                    context,
                    'Item ditambahkan ke keranjang',
                  );
                }
                cartProvider.resetJumlah();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 18),
                color: primary,
                child: Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Column detailProduct(String text, String img, String subtText, int harga) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: primaryText,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            LikeButton(
              size: 40,
              circleColor:
                  CircleColor(start: Colors.red, end: Colors.redAccent),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Colors.red,
                dotSecondaryColor: Colors.redAccent,
              ),
              likeBuilder: (bool isLiked) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  child: isWish
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 32,
                          key: ValueKey<bool>(isLiked),
                        )
                      : Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.grey,
                          size: 32,
                          key: ValueKey<bool>(isLiked),
                        ),
                );
              },
              onTap: (bool isLiked) async {
                WishlistItem item = WishlistItem(
                    harga: harga, img: img, text: text, subtext: subtText);
                Provider.of<WishlistModel>(context, listen: false)
                    .addItemToWishlist(item);
                setState(() {
                  isWish = true;
                });
                NotificationUtils.showNotification(
                  context,
                  'Item ditambahkan ke Wishlist',
                );
                return !isLiked;
              },
            ),
          ],
        ),
        SizedBox(height: 12),
        Text(
          subtText,
          style: TextStyle(color: secondText),
        ),
        SizedBox(height: 12),
        Text(
          NumberFormat.currency(
                  locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0)
              .format(harga)
              .toString(),
          style: TextStyle(
            color: primaryText,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset('assets/icons/star.png'),
                Image.asset('assets/icons/star.png'),
                Image.asset('assets/icons/star.png'),
                Image.asset('assets/icons/star.png'),
                Image.asset('assets/icons/star.png'),
                SizedBox(width: 6),
                Text(
                  '4.5 | Terjual 116',
                  style: TextStyle(
                    color: secondText,
                    fontSize: 12,
                  ),
                )
              ],
            )
          ],
        ),
        SizedBox(height: 24),
        Text(
          'Ruang terbatas bukan berarti Anda harus menolak belajar atau bekerja dari rumah. Meja ini memakan sedikit ruang lantai namun masih memiliki unit laci tempat Anda dapat menyimpan kertas dan barang penting lainnya.',
          style: TextStyle(
            color: primaryText,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  SingleChildScrollView itemScroll(String images) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(images)),
            ),
          ),
          detailItems('assets/images/Rectangle 25.png'),
          SizedBox(width: 16),
          detailItems('assets/images/Rectangle 26.png'),
          SizedBox(width: 16),
          detailItems('assets/images/Rectangle 27.png'),
          SizedBox(width: 16),
          detailItems('assets/images/Rectangle 23.png'),
          SizedBox(width: 16),
          detailItems('assets/images/Rectangle 26.png'),
          SizedBox(width: 16),
          detailItems('assets/images/Rectangle 27.png'),
          SizedBox(width: 16),
          detailItems('assets/images/Rectangle 23.png'),
        ],
      ),
    );
  }

  Container detailItems(String img) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(img)),
      ),
    );
  }
}