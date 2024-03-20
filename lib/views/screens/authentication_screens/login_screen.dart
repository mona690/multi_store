import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/controllers/auth_controller.dart';
import 'package:macstore/vendor/authentication/vendor_register_screen.dart';
import 'package:macstore/views/screens/authentication_screens/register_screen.dart';
import 'package:macstore/views/screens/main_screen.dart';
import 'package:macstore/views/screens/widgets/button_widget.dart';
import 'package:macstore/views/screens/widgets/custom_text_Field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

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
          await _authController.loginUser(email, password);

      setState(() {
        _isLoading = false;
        loginStatus = res['status'];
      });

      if (loginStatus == 'success') {
        String userRole = res['role'];

        if (userRole == 'buyer') {
          Get.offAll(MainScreen());
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('تم تسجيل الدخول كمشترى')));
        } else {
          // Handle unexpected role or show an error message
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('دور المستخدم غير صالح. يرجى الاتصال بالدعم.'),
            backgroundColor: Colors.orange[200],
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login failed. $loginStatus'),
          backgroundColor: Colors.orange[200],
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
                      "فم بتسجيل الدخول لحسابك",
                      style: GoogleFonts.roboto(
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 23,
                      ),
                    ),
                    Text(
                      ' لاستكشاف الحصرى عالميا ',
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
                        'الايميل',
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
                          return ' ادخل الايميل ';
                        } else {
                          return null;
                        }
                      },
                      label: 'ادخل الايميل ',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'ادخل الايميل',
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
                      buttonTitle: 'تسجيل دخول',
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
                          'جديد فى ماركة ؟',
                          style: GoogleFonts.roboto(),
                          textAlign: TextAlign.end, 
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
                            'انشاء حساب  ',
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                        Text(
                          'انشاء حساب كبائع؟',
                          style: GoogleFonts.roboto(),
                          textAlign: TextAlign.end, 
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
