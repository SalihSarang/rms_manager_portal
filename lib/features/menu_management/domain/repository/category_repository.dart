import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
abstract class ICategoryRepository {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
}
