import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/provider/product_provider.dart';
import 'package:macstore/views/screens/inner_screen/payment_screen.dart';
import 'package:macstore/views/screens/inner_screen/shipping_address_screen.dart';
import 'package:macstore/views/screens/main_screen.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment(double totalPrice, dynamic data) async {}

  displayPaymentSheet(dynamic data) async {}

  String? selectedPaymentOption;
  // Variables to store user data
  String pinCode = '';
  String locality = '';
  String city = '';
  String state = '';

  @override
  void initState() {
    super.initState();
    // Call the method to set up the stream
    _setupUserDataStream();
  }

  void _setupUserDataStream() {
    // Create a stream of the user data
    Stream<DocumentSnapshot> userDataStream =
        _firestore.collection('buyers').doc(_auth.currentUser!.uid).snapshots();

    // Listen to the stream and update the UI when there's a change
    userDataStream.listen((DocumentSnapshot userData) {
      if (userData.exists) {
        setState(() {
          pinCode = userData.get('pinCode');
          locality = userData.get('locality');
          city = userData.get('city');
          state = userData.get('state');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _cartProvider = ref.read(cartProvider.notifier);

    final cartData = ref.watch(cartProvider);
    final totalAmount = ref.read(cartProvider.notifier).calculateTotalAmount();
    double total = totalAmount + 10;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Checkout',
          style: GoogleFonts.getFont(
            'Lato',
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ShippingAddressScreen();
                  }));
                },
                child: SizedBox(
                  width: 335,
                  height: 74,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 336,
                          height: 75,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFFEFF0F2),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 70,
                        top: 17,
                        child: SizedBox(
                          width: 215,
                          height: 41,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: -1,
                                top: -1,
                                child: SizedBox(
                                  width: 219,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ShippingAddressScreen();
                                          }));
                                        },
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: SizedBox(
                                            width: 114,
                                            child: Text(
                                              state == ""
                                                  ? "Add address"
                                                  : state,
                                              style: GoogleFonts.getFont(
                                                'Lato',
                                                color: const Color(0xFF0B0C1E),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                height: 1.3,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          city == ""
                                              ? "Enter City"
                                              : locality + " " + city,
                                          style: GoogleFonts.getFont(
                                            'Lato',
                                            color: Color.fromARGB(
                                                255, 222, 199, 116),
                                            fontSize: 12,
                                            height: 1.6,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 16,
                        child: SizedBox.square(
                          dimension: 42,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBF7F5),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Positioned(
                                        left: 11,
                                        top: 11,
                                        child: Image.network(
                                          'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F2ee3a5ce3b02828d0e2806584a6baa88.png',
                                          width: 20,
                                          height: 20,
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 11,
                                top: 11,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  clipBehavior: Clip.hardEdge,
                                  decoration: const BoxDecoration(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 305,
                        top: 25,
                        child: Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/codeless-app.appspot.com/o/projects%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F6ce18a0efc6e889de2f2878027c689c9caa53feeedit%201.png?alt=media&token=a3a8a999-80d5-4a2e-a9b7-a43a7fa8789a',
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Order',
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: cartData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final cartItem = cartData.values.toList()[index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: 336,
                        height: 91,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFEFF0F2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 6,
                              top: 6,
                              child: SizedBox(
                                width: 311,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 78,
                                      height: 78,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 222, 199, 116),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Image.network(
                                          cartItem.imageUrl[0].toString()),
                                    ),
                                    const SizedBox(width: 11),
                                    Expanded(
                                      child: Container(
                                        height: 78,
                                        alignment: const Alignment(0, -0.51),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  cartItem.productName,
                                                  style: GoogleFonts.getFont(
                                                    'Lato',
                                                    color:
                                                        const Color(0xFF0B0C1E),
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  cartItem.catgoryName,
                                                  style: GoogleFonts.getFont(
                                                    'Lato',
                                                    color:
                                                        const Color(0xFF7F808C),
                                                    fontSize: 12,
                                                    height: 1.6,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Container(
                                      height: 78,
                                      alignment: const Alignment(0, -0.03),
                                      child: Text(
                                        '\Eg' +
                                            cartItem.discount
                                                .toStringAsFixed(2),
                                        style: GoogleFonts.getFont(
                                          'Lato',
                                          color: const Color(0xFF0B0C1E),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          height: 1.3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              SizedBox(
                height: 25,
              ),
              Text(
                'Payment Method',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ////Cash on Delivery Section
              SizedBox(
                width: 344,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 67,
                      alignment: const Alignment(0, 0.06),
                      child: SizedBox.square(
                        dimension: 32,
                        child: Radio<String>(
                          value: 'CashOnDelivery',
                          groupValue: selectedPaymentOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentOption = value;
                              print(selectedPaymentOption);
                            });
                          },
                          activeColor: const Color.fromARGB(255, 225, 155, 16),
                          fillColor: MaterialStateProperty.resolveWith(
                            (states) => states.contains(MaterialState.selected)
                                ? const Color.fromARGB(255, 225, 155, 16)
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      // Use Expanded to allow the text to take available space
                      child: Container(
                        height: 67,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFEFF0F2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 37,
                              top: 12,
                              child: SizedBox(
                                width: 195,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 43,
                                      height: 43,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFBF7F5),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: Icon(
                                        Icons.delivery_dining,
                                      ),
                                    ),
                                    Container(
                                      height: 43,
                                      alignment: const Alignment(0, -0.09),
                                      child: Text(
                                        'Cash On Delivery',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

// pay-tab Payment section
              SizedBox(
                width: 343,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 67,
                      alignment: const Alignment(0, 0.03),
                      child: SizedBox.square(
                        dimension: 32,
                        child: Radio<String>(
                          value: 'Pay-Tab',
                          groupValue: selectedPaymentOption,
                          onChanged: (value) {
                            setState(() {
                              selectedPaymentOption = value;
                            });
                          },
                          activeColor: const Color.fromARGB(255, 225, 155, 16),
                          fillColor: MaterialStateProperty.resolveWith(
                            (states) => states.contains(MaterialState.selected)
                                ? Color.fromARGB(255, 225, 155, 16)
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 11),
                    Expanded(
                      // Use Expanded to allow the text to take available space
                      child: Container(
                        height: 67,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFEFF0F2),
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              left: 37,
                              top: 10,
                              child: SizedBox(
                                width: 179,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 46,
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 43,
                                        height: 43,
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFBF7F5),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Icon(
                                          CupertinoIcons.money_dollar,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 43,
                                      alignment: const Alignment(0, -0.09),
                                      child: Text(
                                        'PAY-TAP',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///sumary
              ///
              SizedBox(
                height: 20,
              ),
              Container(
                width: 336,
                height: 200,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Summary',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF0B0C1E),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    _row(
                        'Payment Method',
                        selectedPaymentOption == 'CashOnDelivery'
                            ? "COD"
                            : 'Pay-Tab'),
                    _row('sub-total(${cartData.length} items) ',
                        "\Eg" + totalAmount.toStringAsFixed(2)),
                    _row('Delivery Fee', '${"\Eg" + "10"}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "\Eg" + total.toStringAsFixed(2),
                          style: GoogleFonts.getFont(
                            'Lato',
                            color: const Color.fromARGB(255, 225, 155, 16),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.6,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (selectedPaymentOption == 'Pay-Tab') {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PaymentScreen(); // Navigate to PaymentScreen
              }));
            } else {
              DocumentSnapshot userDoc = await _firestore
                  .collection('buyers')
                  .doc(_auth.currentUser!.uid)
                  .get();

              if (selectedPaymentOption == 'CashOnDelivery') {
                // Handling Cash on Delivery option
                // Save order details and update sales count in the product collection
                await Future.forEach(_cartProvider.getCartItems.entries,
                    (entry) async {
                  final orderId = Uuid().v4();
                  var item = entry.value;

                  // Update the sales count for the product

                  // Save order details
                  await _firestore.collection('orders').doc(orderId).set({
                    'orderId': orderId,
                    'productName': item.productName,
                    'productId': item.productId,
                    'size': item.productSize,
                    'quantity': item.quantity,
                    'price': item.quantity * item.productPrice,
                    'productCategory': item.catgoryName,
                    'productImage': item.imageUrl[0],
                    'state': state,
                    'locality': locality,
                    'pinCode': pinCode,
                    'city': city,
                    'fullName':
                        (userDoc.data() as Map<String, dynamic>)['fullName'],
                    'email': (userDoc.data() as Map<String, dynamic>)['email'],
                    'buyerId': _auth.currentUser!.uid,
                    "deliveredCount": 0,
                    "delivered": false,
                    "processing": true,
                    // 'storeId': item.storeId,
                  });
                }).whenComplete(() {
                  setState(() {
                    _isLoading = false;
                    _cartProvider.getCartItems.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MainScreen();
                    }));
                  });
                });
              } else {
                makePayment(
                    totalAmount, userDoc); // Handling other payment methods
              }
            }
          },
          child: Container(
            width: 338,
            height: 58,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 225, 155, 16),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Pay Now',
                      style: GoogleFonts.getFont(
                        'Lato',
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _row(title, subtitle) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.getFont(
            'Lato',
            color: const Color.fromARGB(255, 222, 199, 116),
            fontSize: 14,
            height: 1.6,
          ),
        ),
        Text(
          subtitle,
          style: GoogleFonts.getFont(
            'Lato',
            color: const Color(0xFF0B0C1E),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.6,
          ),
        ),
      ],
    ),
  );
}
