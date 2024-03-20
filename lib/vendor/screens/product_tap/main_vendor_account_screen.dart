import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/vendor/screens/product_tap/main_tab_screen.dart';
import 'package:macstore/vendor/screens/vendor_account_screen.dart';

class MainTabVendoraccount extends StatelessWidget {
  const MainTabVendoraccount({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color.fromARGB(255, 248, 181, 80),
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                'الصفحة الرئسية',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                ),
              ),
            ),
            Tab(
              child: Text(
                ' المنتج',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            VendorAccountScreen(),
            MainTabScreen(),
          ],
        ),
      ),
    );
  }
}
