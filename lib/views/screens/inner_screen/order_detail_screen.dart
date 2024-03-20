import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class OrderDetail extends StatefulWidget {
  final dynamic orderData;

  OrderDetail({super.key, this.orderData});

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  double rating = 0;

  final TextEditingController _reviewTextController = TextEditingController();

  Future<void> markAsDelivered() async {
    try {
      // Update 'delivered' status to true and increment 'deliveredCount' in Firestore
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderData['orderId'])
          .update({
        'delivered': true,
        'deliveredCount': FieldValue.increment(1),
      });

      // You might want to show a confirmation message to the user
    } catch (error) {
      print('Error marking order as delivered: $error');
    }
  }

  Future<bool> hasUserReviewedProduct(String productId) async {
    final user = FirebaseAuth.instance.currentUser;
    final querySnapshot = await FirebaseFirestore.instance
        .collection('productReviews')
        .where('productId', isEqualTo: productId)
        .where('uid', isEqualTo: user!.uid)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> updateProductRating(String productId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('productReviews')
        .where('productId', isEqualTo: productId)
        .get();

    double totalRating = 0;
    int totalReviews = querySnapshot.docs.length;

    for (final doc in querySnapshot.docs) {
      totalRating += doc['rating'];
    }

    final double averageRating =
        totalReviews > 0 ? totalRating / totalReviews : 0;

    // Update the product's rating in the 'products' collection
    await FirebaseFirestore.instance
        .collection('products')
        .doc(productId)
        .update({
      'rating': averageRating,
      'totalReviews': totalReviews,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 225, 155, 16),
        ),
        title: Text(
          widget.orderData['productName'],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: 335,
            height: 153,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(),
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 336,
                      height: 154,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: const Color(0xFFEFF0F2),
                        ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 13,
                            top: 9,
                            child: Container(
                              width: 78,
                              height: 78,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: const Color(0xFFBCC5FF),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 5,
                                    child: Image.network(
                                      widget.orderData['productImage'],
                                      width: 58,
                                      height: 67,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 101,
                            top: 14,
                            child: SizedBox(
                              width: 216,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
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
                                              widget.orderData['productName'],
                                              style: GoogleFonts.getFont(
                                                'Lato',
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 4),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              widget
                                                  .orderData['productCategory'],
                                              style: GoogleFonts.getFont(
                                                'Lato',
                                                color: const Color(0xFF7F808C),
                                                fontSize: 12,
                                                height: 1.6,
                                              ),
                                            ),
                                          ),
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Size: ${widget.orderData['size']}',
                                              style: GoogleFonts.getFont(
                                                'Lato',
                                                color: const Color(0xFF7F808C),
                                                fontSize: 12,
                                                height: 1.6,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 10),
                                  ),
                                  Container(
                                    height: 63,
                                    alignment: const Alignment(0, -0.07),
                                    child: Text(
                                      '\Egp' +
                                          widget.orderData['price'].toString(),
                                      style: GoogleFonts.getFont(
                                        'Lato',
                                        color: const Color(0xFF0B0C1E),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
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
                  ),
                  Positioned(
                    left: 0,
                    top: 96,
                    child: Image.network(
                      'https://storage.googleapis.com/codeless-dev.appspot.com/uploads%2Fimages%2Fnn2Ldqjoc2Xp89Y7Wfzf%2F0c22142f0880fed29e95291c0b438b13.png',
                      width: 335,
                      height: 1,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    left: 13,
                    top: 113,
                    child: Container(
                      width: 77,
                      height: 25,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: widget.orderData['delivered'] == true
                            ? const Color.fromARGB(255, 225, 155, 16)
                            : widget.orderData['processing'] == true
                                ? Colors.green[400]
                                : Colors.red,
                        // color: const Color(0xFF3C55EF),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: 9,
                            top: 3,
                            child: Text(
                              widget.orderData['delivered'] == true
                                  ? "Delivered"
                                  : widget.orderData['processing'] == true
                                      ? "Processing"
                                      : 'Cancelled',
                              style: GoogleFonts.getFont(
                                'Lato',
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 298,
                    top: 115,
                    child: Container(
                      width: 20,
                      height: 20,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          // Positioned(
                          //   left: 0,
                          //   top: 0,
                          //   child: InkWell(
                          //     onTap: () {},
                          //     child: Image.asset(
                          //       'assets/icons/delete.png',
                          //       width: 20,
                          //       height: 20,
                          //       fit: BoxFit.contain,
                          //     ),
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: 336,
              height: 154,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color(0xFFEFF0F2),
                ),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'عنوان التوصيل ',
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          widget.orderData['locality'] +
                              widget.orderData['pinCode'],
                          style: GoogleFonts.getFont(
                            'Lato',
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          widget.orderData['city'] + widget.orderData['state'],
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'To' + " " + widget.orderData['fullName'],
                          style: GoogleFonts.quicksand(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          widget.orderData['delivered'] == true
              ? ElevatedButton(
                  onPressed: () async {
                    final productId = widget.orderData['productId'];
                    final hasReviewed = await hasUserReviewedProduct(productId);

                    if (hasReviewed) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content:
                              Text('لقد قمت بالفعل بتقييم هذا المنتج.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('تقييم المنتج'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: _reviewTextController,
                                decoration: InputDecoration(
                                  labelText: 'تقييمك',
                                ),
                                // Add any necessary validation or controller properties
                                // to handle the review text input
                                // Example: validator, controller, etc.
                              ),
                              RatingBar.builder(
                                initialRating:
                                    rating, // Set the initial rating value
                                minRating: 1, // Minimum rating value
                                maxRating: 5, // Maximum rating value
                                direction: Axis
                                    .horizontal, // Horizontal or vertical display of rating stars
                                allowHalfRating:
                                    true, // Allow half-star ratings
                                itemCount:
                                    5, // Number of rating stars to display
                                itemSize: 24, // Size of each rating star
                                unratedColor:
                                    Colors.grey, // Color of unrated stars
                                itemPadding: EdgeInsets.symmetric(
                                    horizontal:
                                        4.0), // Padding between rating stars
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ), // Custom builder for rating star widget
                                onRatingUpdate: (value) {
                                  rating = value;

                                  // Handle the rating update here
                                  // This callback will be triggered when the user updates the rating
                                  print(rating);
                                },
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                print('passwing');
                                // Save the review and perform any necessary actions
                                // Example: Call a function to save the review to the database

                                final review = _reviewTextController.text;

                                await FirebaseFirestore.instance
                                    .collection('productReviews')
                                    .add({
                                  'productId': productId,
                                  'fullName': widget.orderData['fullName'],
                                  'email': widget.orderData['email'],
                                  'uid': FirebaseAuth.instance.currentUser!.uid,
                                  'rating': rating,
                                  'review': review,
                                  'timestamp': Timestamp.now(),
                                }).whenComplete(() {});

                                updateProductRating(productId);

                                Navigator.pop(context); // Close the dialog
                                _reviewTextController.clear();
                                rating = 0;
                              },
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Text('Leave a Review'),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}


//  Future<void> markAsDelivered() async {
//     try {
//       // Update 'delivered' status to true and increment 'deliveredCount' in Firestore
//       await FirebaseFirestore.instance
//           .collection('orders')
//           .doc(orderData['orderId'])
//           .update({
//         'delivered': true,
//         'deliveredCount': FieldValue.increment(1),
//       });

//       // You might want to show a confirmation message to the user
//     } catch (error) {
//       print('Error marking order as delivered: $error');
//     }
//   }