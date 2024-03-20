import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:macstore/constants/global_variables.dart';
import 'package:macstore/provider/favorite_provider.dart';
import 'package:macstore/views/screens/main_screen.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    final _favoriteProvider = ref.read(favoriteProvider.notifier);
    final _wishItem = ref.watch(favoriteProvider);
    return Scaffold(
       appBar: PreferredSize(
  preferredSize: Size.fromHeight(kToolbarHeight),
  child: AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 322,
            top: 52,
            child: Image.asset(
              'assets/icons/not.png',
              width: 26,
              height: 26,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            right: 38,
            top: 52,
            child: badges.Badge(
              badgeStyle: badges.BadgeStyle(
                badgeColor: const Color.fromRGBO(206, 147, 216, 1),
              ),
              badgeContent: Text(
                _wishItem.length.toString(),
                style: GoogleFonts.lato(
                  // fontSize: 11,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            left: 61,
            top: 51,
            child: Text(
              'المفضل',
              style: GoogleFonts.getFont(
                'Lato',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),

        body: _wishItem.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'قائمة  المفضل الخاصة بك فارغة\n يمكنك إضافة المنتج إلى قائمة  المفضل الخاصة بك من خلال الزر',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 17,
                        letterSpacing: 1.7,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return MainScreen();
                        }));
                      },
                      child: Text('اضف للقائمة'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: _wishItem.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final wishData = _wishItem.values.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 335,
                        height: 96,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: SizedBox(
                          width: double.infinity,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 336,
                                  height: 97,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFEFF0F2),
                                    ),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 13,
                                top: 9,
                                child: Container(
                                  width: 78,
                                  height: 78,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFBCC5FF),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 275,
                                top: 16,
                                child: Text(
                                  '\[جنيه مصرى]' + wishData.price.toStringAsFixed(2),
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    color: const Color(0xFF0B0C1E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 101,
                                top: 14,
                                child: SizedBox(
                                  width: 162,
                                  child: Text(
                                    wishData.productName,
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 101,
                                top: 37,
                                child: Text(
                                  'Winter Cloths',
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    color: Color.fromARGB(255, 222, 199, 116),
                                    fontSize: 12,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 101,
                                top: 56,
                                child: Text(
                                  'Size: ${wishData.productSize}',
                                  style: GoogleFonts.getFont(
                                    'Lato',
                                    color: Color.fromARGB(255, 222, 199, 116),
                                    fontSize: 12,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 23,
                                top: 14,
                                child: Image.network(
                                  wishData.imageUrl[0],
                                  width: 58,
                                  height: 67,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 284,
                                top: 47,
                                child: InkWell(
                                  onTap: () {
                                    _favoriteProvider
                                        .removeItem(wishData.productId);
                                  },
                                  child: Image.asset(
                                    'assets/icons/delete.png',
                                    width: 28,
                                    height: 28,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }));
  }
}
