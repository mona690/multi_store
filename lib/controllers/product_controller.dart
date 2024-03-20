import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macstore/models/product_models.dart';

class ProductService {
  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  Future<List<CartModel>> searchProducts(String searchText) async {
    try {
      QuerySnapshot querySnapshot = await productsCollection
          .where('productName', isGreaterThanOrEqualTo: searchText)
          .get();

      List<CartModel> products = querySnapshot.docs
          .map((doc) => CartModel(
                productName: doc['productName'],
                productPrice: doc['productPrice'],
                catgoryName: doc['catgoryName'],
                imageUrl: List.from(doc['imageUrl']),
                quantity: 0, // You might need to adjust this
                productId: doc['productId'],
                productSize: doc['productSize'],
                discount: doc['discountPrice'],
                description: doc['description'], 
                //storeId:doc['storeId'] ,
              ))
          .toList();

      return products;
    } catch (e) {
      print('Error searching products: $e');
      return [];
    }
  }
}
