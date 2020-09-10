import 'package:clothiesApp/blocs/itemsBloc.dart';
import 'package:clothiesApp/models/categoryModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/itemCard.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsScreen extends StatefulWidget {
  Category category;
  ItemsScreen(this.category, {Key key}) : super(key: key);

  @override
  _ItemsScreenState createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text(widget.category.name,
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ItemsScreenBloc(PostsRepastory())
          ..add(FetchItemsScreen(widget.category.id)),
        child: BlocBuilder<ItemsScreenBloc, ItemsScreenState>(
          builder: (context, state) {
            if (state is ItemsLoaded) {
              return Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ItemCard(
                        data: state.itemData.items[index], index: index);
                  },
                  itemCount: state.itemData.items.length,
                ),
              );
            }
            if (state is ItemsScreenUninitialized) {
              return Center(
                child: Container(child: circularProgress()),
              );
            }
            if (state is ItemsScreenError) {
              return networkError2("لا يوجد اتصال");
            }
            if (state is ItemsScreenNetworkError) {
              return networkError2("حدث خطأ ما");
            }
          },
        ),
      ),
    );
  }
}
