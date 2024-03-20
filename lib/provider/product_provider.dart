import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:macstore/models/product_models.dart';

final cartProvider =
    StateNotifierProvider<CartNotifier, Map<String, CartModel>>(
        (ref) => CartNotifier());

class CartNotifier extends StateNotifier<Map<String, CartModel>> {
  CartNotifier() : super({});

  void addProductToCart({
    required String productName,
    required num productPrice,
    required String catgoryName,
    required List imageUrl,
    required int quantity,
    required String productId,
    required String productSize,
    required num discount,
    required String description,
   // required String storeId,
  }) {
    if (state.containsKey(productId)) {
     state = {
  ...state,
  productId: CartModel(
    productId: productId,
    productName: productName,
    productPrice: productPrice,
    catgoryName: catgoryName,
    quantity: quantity + 1,
    imageUrl: imageUrl,
    productSize: productSize,
    discount: discount,
    description: description,
   // storeId:  storeId,
  )
};
    } else {
      state = {
        ...state,
        productId: CartModel(
          productName: productName,
          productPrice: productPrice,
          catgoryName: catgoryName,
          imageUrl: imageUrl,
          quantity: quantity,
          productId: productId,
          productSize: productSize,
          discount: discount,
          description: description,
         // storeId: storeId,
        )
      };
    }
  }

  void decrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;

      ///notify listeners that the state has changed
      ///
      state = {...state};
    }
  }

  void removeItem(String productId) {
    state.remove(productId);

    state = {...state};
  }

  void incrementItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;

      ///notify listeners that the state has changed
      ///
      state = {...state};
    }
  }

  double calculateTotalAmount() {
    double totalAmount = 0.0;
    state.forEach((productId, cartItem) {
      totalAmount += cartItem.quantity * cartItem.discount;
    });

    return totalAmount;
  }

  Map<String, CartModel> get getCartItems => state;
}