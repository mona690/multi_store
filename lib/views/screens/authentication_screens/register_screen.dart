import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/controllers/auth_controller.dart';
import 'package:macstore/vendor/authentication/vendor_login_Screen.dart';
import 'package:macstore/views/screens/authentication_screens/login_screen.dart';
import 'package:macstore/views/screens/widgets/button_widget.dart';
import 'package:macstore/views/screens/widgets/custom_text_Field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  late String email;

  late String fullName;

  late String password;

  registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      String res = await _authController.createNewUser(
        email,
        fullName,
        password,
      );

      setState(() {
        _isLoading = false;
      });

      if (res == 'success') {
        Get.to(LoginScreen());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('تم إنشاء حساب مبروك لك..')));
                Colors.amber;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('something went wrong'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('الرجاء إدخال كافة البيانات')));
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
                      "أنشئ حسابك",
                      style: GoogleFonts.roboto(
                        color: Color(0xFF0d120E),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.2,
                        fontSize: 23,
                      ),
                    ),
                    Text(
                      'لاستكشاف الحصرى',
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
                        ' البريد الإلكتروني',
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
                          return 'أدخل بريدك الإلكتروني';
                        } else {
                          return null;
                        }
                      },
                      label: 'أدخل بريدك الإلكتروني',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/email.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'ادخل  البريد الالكترونى',
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        'الاسم بالكامل',
                        style: GoogleFonts.getFont(
                          'Nunito Sans',
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        fullName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'أدخل اسمك الكامل';
                        } else {
                          return null;
                        }
                      },
                      label: 'أدخل اسمك الكامل',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/user.jpeg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'ادخل الايميل',
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
                          return 'ادخل رقمك السري';
                        } else {
                          return null;
                        }
                      },
                      label: 'ادخل رقمك السري',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'assets/icons/password.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      text: 'ادخل كلمة المرور',
                    ),
                    ButtonWidgets(
                      isLoading: _isLoading ? true : false,
                      buttonChange: () {
                        if (_formKey.currentState!.validate()) {
                          registerUser();
                        } else {
                          print('faile');
                        }
                      },
                      buttonTitle: 'انشاء حساب',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(LoginScreen());
                          },
                          child: Text(
                            'تسجيل الدخول',
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                        Text(
                          'تسجيل الدخول؟',
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return VendorLoginScreen();
                            }));
                          },
                          child: Text(
                            'تسجيل الدخول',
                            style: GoogleFonts.roboto(),
                          ),
                        ),
                        Text(
                          'تسجيل الدخول كبائع؟',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            letterSpacing: 0.1,
                            height: 1.7,
                            
                          ),
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
