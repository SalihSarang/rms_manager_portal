import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:manager_portal/core/utils/base_remote_datasource.dart';
import 'package:rms_shared_package/constants/db_constants.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';

abstract class ICategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
}

class CategoryRemoteDataSourceImpl with BaseRemoteDataSource implements ICategoryRemoteDataSource {
  final FirebaseFirestore firestore;

  CategoryRemoteDataSourceImpl({required this.firestore});

  CollectionReference<CategoryModel> get _categoryCollection =>
      firestore.collection(MenuDbConstants.categories).withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) => CategoryModel.fromMap(snapshot.data()!..['id'] = snapshot.id),
            toFirestore: (category, _) => category.toMap(),
          );

  @override
  Future<List<CategoryModel>> getCategories() {
    return performSafeCall(
      () async {
        final snapshot = await _categoryCollection.orderBy('sortOrder').get();
        return snapshot.docs.map((doc) => doc.data()).toList();
      },
      taskName: 'CategoryRemoteDataSource.getCategories',
    );
  }

  @override
  Future<void> addCategory(CategoryModel category) {
    return performSafeCall(
      () => _categoryCollection.doc(category.id).set(category),
      taskName: 'CategoryRemoteDataSource.addCategory',
    );
  }

  @override
  Future<void> updateCategory(CategoryModel category) {
    return performSafeCall(
      () async {
        final docRef = _categoryCollection.doc(category.id);
        final doc = await docRef.get();

        if (!doc.exists) {
          throw FirebaseException(
            plugin: 'cloud_firestore',
            code: 'not-found',
            message: 'Category with ID ${category.id} does not exist.',
          );
        }

        return docRef.update(category.toMap());
      },
      taskName: 'CategoryRemoteDataSource.updateCategory',
    );
  }
}
