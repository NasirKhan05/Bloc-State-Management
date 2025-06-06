import 'package:block_state_examples/model/favourite_item_model.dart';
import 'package:equatable/equatable.dart';

enum ListStatus{loading, success, failure}

class FavouriteItemState extends Equatable{

  final List<FavouriteItemModel> favouriteItemList ;
  final List<FavouriteItemModel> temFavouriteItemList ;
  final ListStatus listStatus;

  const FavouriteItemState({
    this.favouriteItemList = const [],
    this.temFavouriteItemList = const [],
    this.listStatus = ListStatus.loading
  });

  FavouriteItemState copyWith({List<FavouriteItemModel>? favouriteItemList, List<FavouriteItemModel>? temFavouriteItemList, ListStatus? listStatus}){
    return FavouriteItemState(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      temFavouriteItemList: temFavouriteItemList ?? this.temFavouriteItemList,
      listStatus: listStatus ?? this.listStatus
    );
  }

  @override
  List<Object> get props => [favouriteItemList, temFavouriteItemList, listStatus] ;
}