import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macstore/models/category_models.dart';

class CategoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _fetchCategories();
  }

  void _fetchCategories() {
    _firestore.collection('categories').snapshots().listen((querySnapshot) {
           print('Query snapshot: $querySnapshot');

      categories.assignAll(
        querySnapshot.docs.map((doc) {
          final data = doc.data();
          // Check if the required fields are not null before using them
        final categoryName = data['categoryName'] as String?;
        final image = data['image'] as String?;
          if (categoryName != null && image != null) {
          return CategoryModel(
            categoryName: categoryName,
            image: image,
          );
        } else {
          // Handle the case where either 'categoryName' or 'categoryImage' is null
          // You might want to log a warning or handle it based on your requirements.
          return CategoryModel(
            categoryName: 'DefaultCategoryName',
            image: 'DefaultCategoryImage',
          );
        }
      }).toList(),
    );
  }, onError: (error) {
    print("Error fetching categories: $error");
  });
}
}