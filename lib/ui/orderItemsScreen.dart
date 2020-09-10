import 'package:clothiesApp/blocs/itemsBloc.dart';
import 'package:clothiesApp/blocs/orderBloc.dart';
import 'package:clothiesApp/models/itemsModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/itemCard.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItemsScreen extends StatefulWidget {
  final int id;
  OrderItemsScreen(this.id, {Key key}) : super(key: key);

  @override
  _OrderItemsScreenState createState() => _OrderItemsScreenState();
}

class _OrderItemsScreenState extends State<OrderItemsScreen> {
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
            child: Text("تفاصيل الطلب",
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ItemsScreenBloc(PostsRepastory())
          ..add(FetchOrderItemsScreen(widget.id)),
        child: BlocBuilder<ItemsScreenBloc, ItemsScreenState>(
          builder: (context, state) {
            if (state is ItemsOrderLoaded) {
              return Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return ItemCard(
                        data: Item(
                            id: state.items.items[index].item.id,
                            name: state.items.items[index].item.name,
                            photo: state.items.items[index].item.photo,
                            model: state.items.items[index].item.model,
                            price: state.items.items[index].item.price,
                            salePrice: state.items.items[index].item.salePrice,
                            description:
                                state.items.items[index].item.description,
                            categoryId:
                                state.items.items[index].item.categoryId,
                            createdAt: state.items.items[index].item.createdAt,
                            updatedAt: state.items.items[index].item.updatedAt),
                        index: index);
                  },
                  itemCount: state.items.items.length,
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
