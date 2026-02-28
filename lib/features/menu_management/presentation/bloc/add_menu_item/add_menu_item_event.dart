import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/menu_models/add_ons_model/add_ons_model.dart';
import 'package:rms_shared_package/models/menu_models/category_model/category_model.dart';
import 'package:rms_shared_package/models/menu_models/portions_and_price/portions_and_price.dart';

abstract class AddMenuItemEvent extends Equatable {
  const AddMenuItemEvent();

  @override
  List<Object?> get props => [];
}

class NameChanged extends AddMenuItemEvent {
  final String name;
  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class DescriptionChanged extends AddMenuItemEvent {
  final String description;
  const DescriptionChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class CategoryChanged extends AddMenuItemEvent {
  final CategoryModel category;
  const CategoryChanged(this.category);

  @override
  List<Object?> get props => [category];
}

class ImageUrlChanged extends AddMenuItemEvent {
  final String imageUrl;
  const ImageUrlChanged(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class PortionAdded extends AddMenuItemEvent {
  final PortionAndPrice portion;
  const PortionAdded(this.portion);

  @override
  List<Object?> get props => [portion];
}

class PortionRemoved extends AddMenuItemEvent {
  final int index;
  const PortionRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class PortionUpdated extends AddMenuItemEvent {
  final int index;
  final PortionAndPrice portion;
  const PortionUpdated(this.index, this.portion);

  @override
  List<Object?> get props => [index, portion];
}

class AddOnAdded extends AddMenuItemEvent {
  final AddOnsModel addOn;
  const AddOnAdded(this.addOn);

  @override
  List<Object?> get props => [addOn];
}

class AddOnRemoved extends AddMenuItemEvent {
  final int index;
  const AddOnRemoved(this.index);

  @override
  List<Object?> get props => [index];
}

class AddOnUpdated extends AddMenuItemEvent {
  final int index;
  final AddOnsModel addOn;
  const AddOnUpdated(this.index, this.addOn);

  @override
  List<Object?> get props => [index, addOn];
}

class IsVegChanged extends AddMenuItemEvent {
  final bool isVeg;
  const IsVegChanged(this.isVeg);

  @override
  List<Object?> get props => [isVeg];
}

class IsFeaturedChanged extends AddMenuItemEvent {
  final bool isFeatured;
  const IsFeaturedChanged(this.isFeatured);

  @override
  List<Object?> get props => [isFeatured];
}

class IsCustomNotesChanged extends AddMenuItemEvent {
  final bool isCustomNotes;
  const IsCustomNotesChanged(this.isCustomNotes);

  @override
  List<Object?> get props => [isCustomNotes];
}

class SubmitFoodItem extends AddMenuItemEvent {
  const SubmitFoodItem();
}

class PickFoodImage extends AddMenuItemEvent {
  const PickFoodImage();
}
