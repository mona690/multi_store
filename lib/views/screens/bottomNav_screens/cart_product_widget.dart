import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:macstore/constants/global_variables.dart';
import 'package:macstore/provider/product_provider.dart';
import 'package:macstore/views/screens/inner_screen/checkout_screen.dart';
import 'package:macstore/views/screens/main_screen.dart';

class CartScreenProduct extends ConsumerStatefulWidget {
  const CartScreenProduct({Key? key});

  @override
  _CartScreenProductState createState() => _CartScreenProductState();
}

class _CartScreenProductState extends ConsumerState<CartScreenProduct> {
  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);
    final cartData = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    // Set a variable to hold the subtotal text
    String subtotalText = 'Subtotal ';
    /*if (cartData.isNotEmpty) {
      subtotalText += '\egp' + totalAmount.toStringAsFixed(2);
      
    }*/
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 322,
                top: 52,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/icons/not.png',
                      width: 26,
                      height: 26,
                      fit: BoxFit.contain,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: badges.Badge(
                        badgeStyle: badges.BadgeStyle(
                          badgeColor: const Color.fromRGBO(206, 147, 216, 1),
                        ),
                        badgeContent: Text(
                          cartData.length.toString(),
                          style: GoogleFonts.lato(
                            // fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 61,
                top: 51,
                child: Text(
                  'عربة التسوق',
                  style: GoogleFonts.getFont(
                    'Lato',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              /*Positioned(
                left: 23,
                top: 57,
                child: Image.asset(
                  'assets/icons/arrow.png',
                  width: 10,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              )*/
            ],
          ),
        ),
      ),
      body: cartData.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'your shopping cart is empty\n you can add product to your cart from the button',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: 17,
                      letterSpacing: 1.7,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return MainScreen();
                      })));
                    },
                    child: Text('Shop Now'),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 49,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 49,
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                              color: Color(0xFFD7DDFF),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 44,
                          top: 19,
                          child: Container(
                            width: 10,
                            height: 10,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 69,
                          top: 14,
                          child: Text(
                            'You have ${cartData.length} items',
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cartData.length,
                          itemBuilder: (context, index) {
                            final cartItem = cartData.values.toList()[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: SizedBox(
                                  height: 200,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          cartItem.imageUrl[0],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cartItem.productName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              cartItem.productPrice
                                                  .toStringAsFixed(2),
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      4,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          _cartProvider
                                                              .decrementItem(
                                                                  cartItem
                                                                      .productId);
                                                        },
                                                        icon: Icon(
                                                          CupertinoIcons.minus,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Text(
                                                        cartItem.quantity
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          _cartProvider
                                                              .incrementItem(
                                                                  cartItem
                                                                      .productId);
                                                        },
                                                        icon: Icon(
                                                          CupertinoIcons.plus,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    _cartProvider.removeItem(
                                                        cartItem.productId);
                                                  },
                                                  icon: Icon(
                                                    CupertinoIcons.delete,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }))
                ],
              ),
            ),
      bottomNavigationBar: Container(
        width: 416,
        height: 89,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 416,
                height: 89,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xFFC4C4C4),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.63, -0.26),
              child: Text(
                subtotalText, // Use the variable here
                style: TextStyle(
                  color: Color(0xFFA1A1A1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Align(
              alignment: Alignment(-0.19, -0.31),
              child: Text(
                cartData.isEmpty
                    ? 'egp 0.00'
                    : '\egp' + totalAmount.toStringAsFixed(2),
                style: TextStyle(
                  color: const Color.fromRGBO(206, 147, 216, 1),
                  fontSize: 10,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0.83, -1),
              child: InkWell(
                onTap: totalAmount == 0.0
                    ? null
                    : () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CheckoutScreen();
                        }));
                      },
                child: Container(
                  width: 130,
                  height: 71,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: totalAmount == 0.0 ? Colors.grey : Colors.amber,
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Checkout',
                          style: GoogleFonts.getFont(
                            'Roboto',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
