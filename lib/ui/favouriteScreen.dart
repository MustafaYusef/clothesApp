import 'package:clothiesApp/blocs/favouriteBloc.dart';
import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/favouriteCard.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../main.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key key}) : super(key: key);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return FavouriteScreenBloc()..add(FetchFavouriteScreen());
        },
        child: Container(
          child: BlocBuilder<FavouriteScreenBloc, FavouriteScreenState>(
            builder: (context, state) {
              if (state is FavouriteScreenUninitialized) {
                return Center(
                  child: Container(child: circularProgress()),
                );
              }
              if (state is FavouriteScreenNetworkError) {
                return networkError2("لا يوجد اتصال");
              }
              if (state is FavouriteScreenError) {
                return networkError2("حدث خطأ ما");
              }
              if (state is FavouriteLoaded) {
                if (state.favDb.length == 0) {
                  return Center(
                    child: Directionality(
                      child: Text(
                        "لا يوجد عناصر",
                        style: TextStyle(fontSize: 20),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  );
                }

                return Container(
                  child: ListView.builder(
                      itemCount: state.favDb.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          actions: <Widget>[
                            IconSlideAction(
                              caption: 'حذف',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                final f = FavouritesDao(database);
                                await f.deletFav(state.favDb[index]);
                                BlocProvider.of<FavouriteScreenBloc>(context)
                                    .add(FetchFavouriteScreen());
                              },
                            ),
                          ],
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'حذف',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () async {
                                final f = FavouritesDao(database);
                                await f.deletFav(state.favDb[index]);
                                BlocProvider.of<FavouriteScreenBloc>(context)
                                    .add(FetchFavouriteScreen());
                              },
                            ),
                          ],
                          actionExtentRatio: 0.35,
                          actionPane: SlidableDrawerActionPane(),
                          child: FavouriteCard(
                              data: state.favDb[index], index: index),
                        );
                      }),
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
