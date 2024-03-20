import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/vendor/authentication/Create_store_screen.dart';
import 'package:macstore/vendor/controllers/vendor_controller.dart';
import 'package:macstore/views/screens/widgets/button_widget.dart';
import 'package:macstore/views/screens/widgets/custom_text_Field.dart';

class VendorRegisterScreen extends StatefulWidget {
  @override
  State<VendorRegisterScreen> createState() => _VendorRegisterScreenState();
}

class _VendorRegisterScreenState extends State<VendorRegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final VendorController _vendorController = VendorController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String comapanyName;

  late String companyNumber;

  late String address;

  late String companyId;

  late String email;

  late String password;

  registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String res = await _vendorController.createNewUser(
          email, comapanyName, companyNumber, password, address, companyId);

      setState(() {
        _isLoading = false;
      });

      if (res == 'success') {
        Get.to(CreateStoreScreen());
        // Add the approval field to the vendor data
        await FirebaseFirestore.instance
            .collection('vendors')
            .doc(_auth.currentUser!.uid)
            .set({
          'approved': false,
          // Add other fields as needed
        }, SetOptions(merge: true));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('something went wrong'),
          ),
        );
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'قم بإنشاء حساب عملك',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'لجعل عملك أكبر',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Image.asset(
                    'assets/images/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'اسم الشركة',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'أدخل اسم شركتك',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/user.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    text: 'أدخل اسم شركتك',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل اسم شركتك';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      comapanyName = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'رقم الشركة',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'أدخل رقم شركتك',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/phone.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    text: 'أدخل رقم شركتك',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل رقم شركتك';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      companyNumber = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'العنوان',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'أدخل عنوانك',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/location.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    text: 'أدخل عنوانك',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل عنوان شركتك';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      address = value;
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      ' رقم هوية الشركة',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'ادخل رقم هوية شركتك',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/images/card.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    text: 'ادخل رقم هوية شركتك',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل رقم هوية شركتك';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      companyId = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'البريد الالكترونى',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'أدخل بريدك الإلكتروني',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/email.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    text: 'أدخل بريدك الإلكتروني ',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'أدخل بريدك الإلكتروني ';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'الرقم السرى',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  CustomTextField(
                    label: 'ادخل رقمك السري',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        'assets/icons/password.png',
                        width: 20,
                        height: 20,
                      ),
                    ),
                    text: 'ادخل رقمك السري',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'ادخل رقمك السري ';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonWidgets(
            buttonChange: () {
              registerUser();
            },
            isLoading: _isLoading ? true : false,
            buttonTitle: 'انشاء حساب',
          ),
        ],
      ),
    );
  }
}
