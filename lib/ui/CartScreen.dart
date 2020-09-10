import 'package:clothiesApp/blocs/cartBloc.dart';
import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/Auth/loginScreen.dart';
import 'package:clothiesApp/ui/uiComponent/CartItemCard.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../main.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) {
          return CartScreenBloc(repo: PostsRepastory())..add(FetchCartScreen());
        },
        child: Container(
          child: BlocBuilder<CartScreenBloc, CartScreenState>(
            builder: (context, state) {
              if (state is CartScreenUninitialized ||
                  state is MakeOrderLoading) {
                return Center(
                  child: Container(child: circularProgress()),
                );
              }
              if (state is CartScreenNetworkError) {
                return networkError2("لا يوجد اتصال");
              }
              if (state is CartScreenError) {
                return networkError2("حدث خطأ ما");
              }
              if (state is CartLoaded) {
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
                } else {
                  return Container(
                    child: Column(
                      children: [
                        Expanded(
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
                                        final f = CartItemsDao(database);
                                        await f.deletItem(state.favDb[index]);
                                        BlocProvider.of<CartScreenBloc>(context)
                                            .add(FetchCartScreen());
                                      },
                                    ),
                                  ],
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                      caption: 'حذف',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () async {
                                        final f = CartItemsDao(database);
                                        await f.deletItem(state.favDb[index]);
                                        BlocProvider.of<CartScreenBloc>(context)
                                            .add(FetchCartScreen());
                                      },
                                    ),
                                  ],
                                  actionExtentRatio: 0.35,
                                  actionPane: SlidableDrawerActionPane(),
                                  child:
                                      CartItemsCard(data: state.favDb[index]),
                                );
                              }),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(left: 10, right: 10, bottom: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  colors: [
                                    Theme.of(context).primaryColorDark,
                                    Theme.of(context).primaryColorLight
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight)),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: RaisedButton(
                                color: Colors.transparent,
                                onPressed: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  String token = await prefs.getString("token");
                                  if (token == "" || token == null) {
                                    Toast.show("يجب تسجيل الدخول", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return LoginScreen();
                                    }));
                                  } else {
                                    BlocProvider.of<CartScreenBloc>(context)
                                        .add(MakeOrder(context: context));
                                  }
                                },
                                child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Text(
                                      "أرسال الطلب",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )),
                              )),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
