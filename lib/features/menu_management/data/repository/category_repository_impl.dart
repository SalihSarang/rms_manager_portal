import 'package:manager_portal/features/menu_management/data/datasources/category_remote_datasource.dart';
import 'package:manager_portal/features/menu_management/domain/repository/category_repository.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';

class CategoryRepositoryImpl implements ICategoryRepository {
  final ICategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<CategoryModel>> getCategories() {
    return remoteDataSource.getCategories();
  }

  @override
  Future<void> addCategory(CategoryModel category) {
    return remoteDataSource.addCategory(category);
  }

  @override
  Future<void> updateCategory(CategoryModel category) {
    return remoteDataSource.updateCategory(category);
  }
}
