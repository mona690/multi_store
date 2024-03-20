import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macstore/constants/global_variables.dart';
 import 'package:macstore/vendor/screens/widgets/vendor_category_item.dart';
import 'package:macstore/vendor/screens/widgets/vendor_recommendedscreen.dart';
import 'package:macstore/vendor/screens/widgets/vendorpopular_producut.dart';
import 'package:macstore/views/screens/inner_screen/search_result_screen.dart';
import 'package:macstore/views/screens/widgets/banner_widget.dart';
import 'package:macstore/views/screens/widgets/reuse_text_widget.dart';
 
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
 @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends ConsumerState<HomeScreen> {

  @override
  Widget build(BuildContext context) {
  final TextEditingController _searchController = TextEditingController();
     return Scaffold(
        appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      // Search bar implementation
                      controller: _searchController,
                      onFieldSubmitted: (query) async {
                         Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => SearchScreen(searchQuery: query),
    ),
  );
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {
                            
                           },
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'ابحث فى ماركة  ...',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            BannerArea(),
            VendorCategoryItem(),
            ResuseTextWidget(title: ' مقترح لك', subtitle: ' الكل',),
            VendorRecommendedProduct(),
            ResuseTextWidget(
              title: 'شائع',
              subtitle: ' الكل',
            ),
            VendorPopularProducts(),
          ],
        ),
      ),
    );
  }
}
