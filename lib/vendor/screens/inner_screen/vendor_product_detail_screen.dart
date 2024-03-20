import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:macstore/utils/show_snackBar.dart';

class VendorProductDetailScreen extends StatefulWidget {
  final dynamic productData;

  const VendorProductDetailScreen({Key? key, required this.productData})
      : super(key: key);

  @override
  _VendorProductDetailScreenState createState() =>
      _VendorProductDetailScreenState();
}

class _VendorProductDetailScreenState extends State<VendorProductDetailScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _productNameController.text = widget.productData['productName'];
    _priceController.text = widget.productData['price'].toString();
    _discountPriceController.text = widget.productData['discountPrice'].toString();
    _productDescriptionController.text = widget.productData['description'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        elevation: 0,
        title: Text(widget.productData['productName']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _productNameController,
              decoration: InputDecoration(labelText: 'اسم المنتج'),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                // Handle price changes
                _priceController.text = value;
              },
              controller: _priceController,
              decoration: InputDecoration(labelText: 'السعر'),
            ),
            SizedBox(height: 20),
            TextFormField(
              onChanged: (value) {
                // Handle discount price changes
                _discountPriceController.text = value;
              },
              controller: _discountPriceController,
              decoration: InputDecoration(labelText: 'سعر المنتج بعد الخصم'),
            ),
            SizedBox(height: 20),
            TextFormField(
              maxLength: 800,
              maxLines: 3,
              controller: _productDescriptionController,
              decoration: InputDecoration(labelText: 'الوصف'),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () async {
            try {
              await _firestore
                  .collection('products')
                  .doc(widget.productData['productId'])
                  .update({
                'productName': _productNameController.text,
                'price': double.tryParse(_priceController.text) ?? 0.0,
                'discountPrice': double.tryParse(_discountPriceController.text) ?? 0.0,
                'description': _productDescriptionController.text,
              });
              showSnack(context, 'تم التحديث بنجاح');
            } catch (error) {
              print('Error updating document: $error');
              showSnack(context, 'Failed to update: $error');
            }
          },
          child: Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.yellow.shade900,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                "تحديث المنتج",
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 6,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
