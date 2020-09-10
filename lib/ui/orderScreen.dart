import 'package:clothiesApp/blocs/orderBloc.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/uiComponent/CartItemCard.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:clothiesApp/ui/uiComponent/orderCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
              child: Text("الطلبات",
                  style: TextStyle(color: Colors.black, fontSize: 22))),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) =>
              OrderScreenBloc(PostsRepastory())..add(FetchOrder()),
          child: BlocBuilder<OrderScreenBloc, OrderScreenState>(
            builder: (context, state) {
              if (state is OrderScreenUninitialized) {
                return Center(
                  child: Container(child: circularProgress()),
                );
              }
              if (state is OrderScreenNetworkError) {
                return networkError2("لا يوجد اتصال");
              }
              if (state is OrderScreenError) {
                return networkError2("حدث خطأ ما");
              }
              if (state is OrdersLoaded) {
                if (state.orders.orders.length == 0) {
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
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: state.orders.orders.length,
                            itemBuilder: (context, index) {
                              return OrderCard(state.orders.orders[index]);
                            }),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
