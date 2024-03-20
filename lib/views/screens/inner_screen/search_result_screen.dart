import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:macstore/views/screens/widgets/popularProduct_models.dart';
import 'package:macstore/constants/global_variables.dart';


class SearchScreen extends StatelessWidget {
  final String searchQuery;

  SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where(
          'productName',
          isEqualTo: searchQuery,
        )
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Text(
          'Search Results for: $searchQuery',
          style: GoogleFonts.getFont(
            'Lato',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _productsStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No results found.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }

            return Container(
              child: GridView.count(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 300 / 500,
                children: List.generate(snapshot.data!.size, (index) {
                  final product = snapshot.data!.docs[index];
                  return PopularModel(
                    popularProduct: product,
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }
}
