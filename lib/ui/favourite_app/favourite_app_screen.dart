
import 'package:block_state_examples/bloc/favourites_app/favourites_app_bloc.dart';
import 'package:block_state_examples/bloc/favourites_app/favourites_app_event.dart';
import 'package:block_state_examples/bloc/favourites_app/favourites_app_state.dart';
import 'package:block_state_examples/model/favourite_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppScreen extends StatefulWidget {
  const FavouriteAppScreen({super.key});

  @override
  State<FavouriteAppScreen> createState() => _FavouriteAppScreenState();
}

class _FavouriteAppScreenState extends State<FavouriteAppScreen> {

  @override
  void initState() {
    super.initState();
    context.read<FavouriteBloc>().add(FetchFavouriteList());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite App'),
        actions: [
          BlocBuilder<FavouriteBloc, FavouriteItemState>(
              builder: (context, state){
                return Visibility(
                  visible: state.temFavouriteItemList.isNotEmpty ? true : false,
                  child: IconButton(
                      onPressed: (){
                        context.read<FavouriteBloc>().add(DeleteItem());
                      },
                      icon: Icon(Icons.delete, color: Colors.red,)
                  ),
                );
              }
          )
        ],
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, top: 10, bottom: 5),
        child: BlocBuilder<FavouriteBloc, FavouriteItemState>(
            builder: (context, state){
              switch(state.listStatus){
                case ListStatus.loading:
                  return Center(child: CircularProgressIndicator());
                case ListStatus.failure:
                  return Text('Something went Wrong');
                case ListStatus.success:
                  return ListView.builder(
                    itemCount: state.favouriteItemList.length,
                      itemBuilder: (context, index){
                      final item = state.favouriteItemList[index];
                      return Card(
                        child: ListTile(
                          leading: Checkbox(
                              value: state.temFavouriteItemList.contains(item) ? true : false,
                            onChanged: (value){
                                if(value!){
                                  context.read<FavouriteBloc>().add(SelectedItem(item: item));
                                }else{
                                  context.read<FavouriteBloc>().add(UnSelectedItem(item: item));
                                }
                            }
                          ),
                          title: Text(item.value.toString()),
                          trailing: IconButton(onPressed: (){

                            FavouriteItemModel itemModel = FavouriteItemModel(
                                id: item.id, value: item.value,
                              isFavourite: item.isFavourite ? false : true
                            );
                            context.read<FavouriteBloc>().add(FavouriteItem(item: itemModel));
                          },
                              icon: Icon(
                                  item.isFavourite ? Icons.favorite : Icons.favorite_outline)
                          ),
                        ),
                      );
                      }
                  );
              }
            }
        ),
      ),
    );
  }
}
