

import 'package:bloc/bloc.dart';
import 'package:block_state_examples/bloc/favourites_app/favourites_app_event.dart';
import 'package:block_state_examples/bloc/favourites_app/favourites_app_state.dart';
import 'package:block_state_examples/model/favourite_item_model.dart';
import 'package:block_state_examples/repository/favourite_repository.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteItemState>{

  List<FavouriteItemModel> favouriteList = [] ;
  List<FavouriteItemModel> temFavouriteList = [] ;

  FavouriteRepository favouriteRepository ;
  FavouriteBloc(this.favouriteRepository) : super (const FavouriteItemState()){
    on<FetchFavouriteList>(fetchList);
    on<FavouriteItem>(_addFavouriteItem);
    on<SelectedItem>(_selectedItem);
    on<UnSelectedItem>(_unSelectedItem);
    on<DeleteItem>(_deleteItem);
  }

  void fetchList(FetchFavouriteList event, Emitter<FavouriteItemState> emit) async{
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(favouriteItemList: List.from(favouriteList), listStatus: ListStatus.success));
  }

  void _addFavouriteItem(FavouriteItem event, Emitter<FavouriteItemState> emit) async{
    final index = favouriteList.indexWhere((element) => element.id == event.item.id);

    if(event.item.isFavourite){
      if(temFavouriteList.contains(favouriteList[index])){
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }
    }else{
      if(temFavouriteList.contains(favouriteList[index])){
        temFavouriteList.remove(favouriteList[index]);
        temFavouriteList.add(event.item);
      }

    }

    favouriteList[index] = event.item;
    emit(state.copyWith(favouriteItemList: List.from(favouriteList), temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _selectedItem(SelectedItem event, Emitter<FavouriteItemState> emit) async{
    temFavouriteList.add(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _unSelectedItem(UnSelectedItem event, Emitter<FavouriteItemState> emit) async{
    temFavouriteList.add(event.item);
    emit(state.copyWith(temFavouriteItemList: List.from(temFavouriteList)));
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteItemState> emit) async{
    for(int i = 0; i < temFavouriteList.length; i++){
      favouriteList.remove(temFavouriteList[i]);
    }
    temFavouriteList.clear();
    emit(state.copyWith(
      favouriteItemList: List.from(favouriteList),
      temFavouriteItemList: List.from(temFavouriteList)
    ));
  }
}