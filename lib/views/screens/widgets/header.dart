import 'package:flutter/material.dart';
import 'search_bar.dart'as CustomSearchBar;  // Import the SearchBar widget

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key, required void Function(String query) onSearchSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.20,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      child: Stack(
        children: [
          Image.asset(
            'assets/icons/searchBanner.jpeg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 48,
            top: 68,
            child: SizedBox(
              width: 250,
              height: 50,
              child: CustomSearchBar.SearchBar(onSearchSubmit: (query) {
                // Handle search submission
                print('Search submitted: $query');
              }),
            ),
          ),
          Positioned(
            left: 311,
            top: 78,
            child: Material(
              // ... existing bell icon ...
            ),
          ),
          Positioned(
            left: 354,
            top: 78,
            child: Material(
              // ... existing chat icon ...
            ),
          ),
        ],
      ),
    );
  }
}
