import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  final Function(String) onSearchSubmit;

  const SearchBar({Key? key, required this.onSearchSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(left: 15),
      child: Material(
        borderRadius: BorderRadius.circular(7),
        elevation: 1,
        child: TextFormField(
          onFieldSubmitted: onSearchSubmit,
          decoration: InputDecoration(
            prefixIcon: InkWell(
              onTap: () {},
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
            hintText: 'Search...',
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}