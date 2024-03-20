import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/vendor/authentication/vendor_register_screen.dart';
import 'package:macstore/vendor/controllers/vendor_controller.dart';
import 'package:macstore/vendor/screens/vendor_main_screen.dart';
import 'package:macstore/views/screens/authentication_screens/register_screen.dart';
import 'package:macstore/views/screens/widgets/button_widget.dart';
import 'package:macstore/views/screens/widgets/custom_text_Field.dart';

class VendorLoginScreen extends StatefulWidget {
  VendorLoginScreen({super.key});

  @override
  State<VendorLoginScreen> createState() => _VendorLoginScreenState();
}

class _VendorLoginScreenState extends State<VendorLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VendorController _authController = VendorController();

  late String email;

  late String password;

  bool _isLoading = false;

  loginUser() async {
    String loginStatus = ''; // Move the variable inside loginUser

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> res =
          await _authController.loginVendorUser(email, password);
      print('Response: $res');
      setState(() {
        _isLoading = false;
        loginStatus = res['status'];
      });

      if (loginStatus == 'success') {
        String userRole = res['role'];
        bool isApproved = res['approved'];

        if (userRole == 'vendor' && isApproved) {
          Get.offAll(vendorMainScreen());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('تم تسجيل دخولك كبائع')));
        } else if (userRole == 'vendor' && !isApproved) {
          // User is not approved, show a message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('لم يتم الموافقة على حسابك بعد.'),
            backgroundColor: Colors.orange,
          ));
        } else {
          // Handle unexpected role or show an error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('دور المستخدم غير صالح. يرجى الاتصال بالدعم.'),
            backgroundColor: Colors.orange,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login failed. $loginStatus'),
          backgroundColor: Colors.orange,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
        0.95,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "تسجيل الدخول كبائغ",
                      style: GoogleFonts.roboto(
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      ' لاستكشاف الحصرى عالميا',
                      style: GoogleFonts.roboto(
                        color: Color(0xFF0d120E),
                        fontSize: 14,
                        letterSpacing: 0.2,
                      ),
                    ),
                    Image.asset(
                      'assets/images/Illustration.png',
                      width: 200,
                      height: 200,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'ايميل',
                        textDirection:
                            TextDirection.rtl, // Set text direction to RTL
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل الايميل';
                        } else {
                          return null;
                        }
                      },
                      label: 'ادخل ايميلك',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'الايميل',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'كلمة المرور',
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    CustomTextField(
                      isPassword: true,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'ادخل كلمة المرور';
                        } else {
                          return null;
                        }
                      },
                      label: 'ادخل كلمة المرور',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/password.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'كلمة المرور',
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonWidgets(
                      isLoading: _isLoading ? true : false,
                      buttonChange: () {
                        if ((_formKey.currentState!.validate())) {
                          loginUser();
                        } else {
                          print('ff');
                        }
                      },
                      buttonTitle: 'تسجيل الدخول',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(RegisterScreen());
                          },
                          child: Text(
                            'انشاء حساب ',
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                        Text(
                          'جديد فى ماركة؟',
                          style: GoogleFonts.roboto(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(VendorRegisterScreen());
                          },
                          child: Text(
                            ' انشاء حساب',
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                        Text(
                          'انشاء حساب كبائغ؟',
                          style: GoogleFonts.roboto(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
