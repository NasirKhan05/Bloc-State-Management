import 'package:block_state_examples/model/favourite_item_model.dart';
import 'package:equatable/equatable.dart';


abstract class FavouriteEvent extends Equatable{
  const FavouriteEvent();

  @override
  List<Object> get props => [] ;
}

class FetchFavouriteList extends FavouriteEvent{}

class FavouriteItem extends FavouriteEvent{
  final FavouriteItemModel item ;
  const FavouriteItem({required this.item});
}

class SelectedItem extends FavouriteEvent{
  final FavouriteItemModel item ;
  const SelectedItem({required this.item});
}

class UnSelectedItem extends FavouriteEvent{
  final FavouriteItemModel item ;
  const UnSelectedItem({required this.item});
}

class DeleteItem extends FavouriteEvent{}