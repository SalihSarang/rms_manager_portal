import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

class AddMenuItemState extends Equatable {
  final String name;
  final String description;
  final String imageUrl;
  final XFile? pickedImage;
  final CategoryModel? category;
  final List<PortionAndPrice> portions;
  final List<AddOnsModel> addOns;
  final bool isVeg;
  final bool isFeatured;
  final bool isCustomNotes;
  final bool isSubmitting;
  final String? errorMessage;
  final bool isSuccess;

  const AddMenuItemState({
    this.name = '',
    this.description = '',
    this.imageUrl = '',
    this.pickedImage,
    this.category,
    this.portions = const [],
    this.addOns = const [],
    this.isVeg = true,
    this.isFeatured = false,
    this.isCustomNotes = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  AddMenuItemState copyWith({
    String? name,
    String? description,
    String? imageUrl,
    XFile? pickedImage,
    CategoryModel? category,
    List<PortionAndPrice>? portions,
    List<AddOnsModel>? addOns,
    bool? isVeg,
    bool? isFeatured,
    bool? isCustomNotes,
    bool? isSubmitting,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return AddMenuItemState(
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      pickedImage: pickedImage ?? this.pickedImage,
      category: category ?? this.category,
      portions: portions ?? this.portions,
      addOns: addOns ?? this.addOns,
      isVeg: isVeg ?? this.isVeg,
      isFeatured: isFeatured ?? this.isFeatured,
      isCustomNotes: isCustomNotes ?? this.isCustomNotes,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [
    name,
    description,
    imageUrl,
    pickedImage,
    category,
    portions,
    addOns,
    isVeg,
    isFeatured,
    isCustomNotes,
    isSubmitting,
    errorMessage,
    isSuccess,
  ];
}
