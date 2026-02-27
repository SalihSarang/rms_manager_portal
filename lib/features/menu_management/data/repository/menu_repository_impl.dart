import 'package:manager_portal/features/menu_management/data/datasources/menu_remote_datasource.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:manager_portal/features/menu_management/domain/repository/menu_repository.dart';

class MenuRepositoryImpl implements MenuRepository {
  final MenuRemoteDatasource remoteDatasource;

  MenuRepositoryImpl(this.remoteDatasource);

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await remoteDatasource.getCategories();
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    await remoteDatasource.addCategory(category);
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    await remoteDatasource.updateCategory(category);
  }
}
