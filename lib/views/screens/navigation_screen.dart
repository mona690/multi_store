import 'package:flutter/material.dart';
import 'package:macstore/constants/global_variables.dart';
import 'package:macstore/vendor/authentication/vendor_login_Screen.dart';
import 'package:macstore/views/screens/authentication_screens/login_screen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool _isCustomerButtonSelected = true;
  bool _isVendorButtonSelected = false;

  void _toggleCustomerButton() {
    setState(() {
      _isCustomerButtonSelected = true;
      _isVendorButtonSelected = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _toggleVendorButton() {
    setState(() {
      _isCustomerButtonSelected = false;
      _isVendorButtonSelected = true;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VendorLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'اهلا بك فى ماركة',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Image.asset(
                'assets/icons/nav_img.gif',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    width: _isCustomerButtonSelected ? 150 : 100,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 249, 209, 148),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: _toggleCustomerButton,
                      child: Text(
                        'انشاء حساب كمشترى',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 30),
                  AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.easeInOut,
                    width: _isVendorButtonSelected ? 150 : 100,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 113, 170, 69),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: _toggleVendorButton,
                      child: Text(
                        'انشاء حساب كبائع',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
