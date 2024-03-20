import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/views/screens/widgets/button_widget.dart';
import 'package:macstore/views/screens/widgets/custom_text_Field.dart';

class ShippingAddressScreen extends StatefulWidget {
  ShippingAddressScreen({super.key});

  @override
  State<ShippingAddressScreen> createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String pinCode;

  late String locality;

  late String city;

  late String state;
  late String mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.96),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.96),
        title: Text(
          'التوصيل ',
          style: GoogleFonts.getFont(
            'Lato',
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 225, 155, 16
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'أين سيتم شحن العناصر\الطلبات الخاصة بك؟',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: 'رمز التعريف الشخصي',
                    prefixIcon: Icon(null),
                    text: ' ادخل رمز التعريف الشخصي',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " ادخل رمز التعريف الشخصى";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      pinCode = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: 'اسم المنطقة',
                    prefixIcon: Icon(null),
                    text: ' ادخل اسم المنطقة',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " ادخل اسم المنطقة";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      locality = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: ' المدينة',
                    prefixIcon: Icon(null),
                    text: ' ادخل اسم المدينة',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " ادخل اسم المدينة";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      city = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    label: 'الدولة',
                    prefixIcon: Icon(null),
                    text: ' ادخل اسم الدولة',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "ادخل اسم الدولة";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      state = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                       label: 'رقم الجوال',
                       prefixIcon: Icon(null),
                      text: ' ادخل رقم الجوال',
                      validator: (value) {
                       if (value!.isEmpty) {
                      return "ادخل رقم الجوال";
                       }                
                        else if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                      return "رقم الجوال يجب أن يتألف من 11 رقم";
                       }                 
                       else {
                      return null;
                        }
                        },
                   onChanged: (value) {
                  mobileNumber = value;
                      },
                   ),
                SizedBox(
                    height: 20,
                  ),
                  ButtonWidgets(
                    isLoading: false,
                   
                    buttonChange: () async {
                      if (_formKey.currentState!.validate()) {
                        _showLoginDialog(context);
                        await _firestore
                            .collection('buyers')
                            .doc(_auth.currentUser!.uid)
                            .update({
                          "pinCode": pinCode,
                          'locality': locality,
                          'city': city,
                          'state': state,
                          'mobileNumber': mobileNumber,
                        }).whenComplete(() {
                          Navigator.pop(context);
                        });
                      }
                    },
                    buttonTitle: 'اذهب إلى الدفع',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('تحديث العنوان'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text('انتظر من فضلك...'),
          ],
        ),
      );
    },
  );

  // Simulate a network call or some asynchronous task
  Future.delayed(Duration(seconds: 3), () {
    // Close the dialog when the task is complete
    Navigator.of(context).pop();
  });
}
