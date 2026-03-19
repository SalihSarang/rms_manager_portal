import 'package:equatable/equatable.dart';
import 'package:rms_shared_package/models/menu_models/food_model/food_model.dart';

abstract class MenuDetailsState extends Equatable {
  const MenuDetailsState();

  @override
  List<Object?> get props => [];
}

class MenuDetailsInitial extends MenuDetailsState {}

class MenuDetailsLoading extends MenuDetailsState {}

class MenuDetailsLoaded extends MenuDetailsState {
  final FoodModel foodItem;

  const MenuDetailsLoaded(this.foodItem);

  @override
  List<Object?> get props => [foodItem];
}

class MenuDetailsError extends MenuDetailsState {
  final String message;

  const MenuDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
