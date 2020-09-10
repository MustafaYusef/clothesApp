// import 'package:clothiesApp/blocs/cartBloc.dart';
// import 'package:clothiesApp/database/database.dart';
// import 'package:clothiesApp/ui/uiComponent/CartItemCard.dart';
// import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
// import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';

// import '../main.dart';
// import 'Auth/loginScreen.dart';

// class CartScreen2 extends StatefulWidget {
//   CartScreen2({Key key}) : super(key: key);

//   @override
//   _CartScreen2State createState() => _CartScreen2State();
// }

// class _CartScreen2State extends State<CartScreen2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Text("سلة المشتريات",
//                 style: TextStyle(color: Colors.black, fontSize: 22))),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: BlocProvider(
//           create: (context) {
//             return CartScreenBloc()..add(FetchCartScreen());
//           },
//           child: Container(
//             child: BlocBuilder<CartScreenBloc, CartScreenState>(
//               builder: (context, state) {
//                 if (state is CartScreenUninitialized) {
//                   return Center(
//                     child: Container(
//                         width: 40, height: 40, child: circularProgress()),
//                   );
//                 }
//                 if (state is CartScreenNetworkError) {
//                   return networkError2("لا يوجد اتصال");
//                 }
//                 if (state is CartScreenError) {
//                   return networkError2("حدث خطأ ما");
//                 }
//                 if (state is CartLoaded) {
//                   return Column(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           child: ListView.builder(
//                               itemCount: state.favDb.length,
//                               itemBuilder: (context, index) {
//                                 return Slidable(
//                                   actions: <Widget>[
//                                     IconSlideAction(
//                                       caption: 'حذف',
//                                       color: Colors.red,
//                                       icon: Icons.delete,
//                                       onTap: () async {
//                                         final f = CartItemsDao(database);
//                                         await f.deletItem(state.favDb[index]);
//                                         BlocProvider.of<CartScreenBloc>(context)
//                                             .add(FetchCartScreen());
//                                       },
//                                     ),
//                                   ],
//                                   secondaryActions: <Widget>[
//                                     IconSlideAction(
//                                       caption: 'حذف',
//                                       color: Colors.red,
//                                       icon: Icons.delete,
//                                       onTap: () async {
//                                         final f = CartItemsDao(database);
//                                         await f.deletItem(state.favDb[index]);
//                                         BlocProvider.of<CartScreenBloc>(context)
//                                             .add(FetchCartScreen());
//                                       },
//                                     ),
//                                   ],
//                                   actionExtentRatio: 0.35,
//                                   actionPane: SlidableDrawerActionPane(),
//                                   child: CartItemsCard(
//                                       data: state.favDb[index], index: index),
//                                 );
//                               }),
//                         ),
//                       ),
//                       Container(
//                         margin:
//                             EdgeInsets.only(left: 10, right: 10, bottom: 15),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                             gradient: LinearGradient(
//                                 colors: [
//                                   Theme.of(context).primaryColorDark,
//                                   Theme.of(context).primaryColorLight
//                                 ],
//                                 begin: Alignment.centerLeft,
//                                 end: Alignment.centerRight)),
//                         height: 60,
//                         width: MediaQuery.of(context).size.width,
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: RaisedButton(
//                               color: Colors.transparent,
//                               onPressed: () async {
//                                 SharedPreferences prefs =
//                                     await SharedPreferences.getInstance();
//                                 String token = await prefs.getString("token");
//                                 if (token == "" || token == null) {
//                                   Toast.show("يجب تسجيل الدخول", context,
//                                       duration: Toast.LENGTH_LONG,
//                                       gravity: Toast.BOTTOM);
//                                   Navigator.push(context,
//                                       MaterialPageRoute(builder: (_) {
//                                     return LoginScreen();
//                                   }));
//                                 } else {
//                                   //Todo make order
//                                 }
//                               },
//                               child: Directionality(
//                                   textDirection: TextDirection.rtl,
//                                   child: Text(
//                                     "أرسال الطلب",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 20),
//                                   )),
//                             )),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
