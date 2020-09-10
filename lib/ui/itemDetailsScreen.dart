import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothiesApp/blocs/itemDetailsBloc.dart';
import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/itemDetailsModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/CartScreen.dart';
import 'package:clothiesApp/ui/uiComponent/CartItemCard.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';

import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:clothiesApp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:toast/toast.dart';

import '../main.dart';
import 'CartScreen2.dart';

class ItemDetailsScreen extends StatefulWidget {
  int _current = 0;
  int id;

  ItemDetailsScreen(this.id, {Key key}) : super(key: key);
  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

int count = 0;
String color = "";
String size = "";
List<int> favList = [];

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
  }

  int cart = 0;
  getCart() async {
    final db = CartItemsDao(database);
    final result = await db.getAllItems();
    cart = result.length;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text("التفاصيل",
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return Main(2);
                  },
                  transitionsBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child) {
                    return Align(
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(right: 20, top: 10),
              child: Badge(
                position: BadgePosition.topRight(),
                badgeContent: Text(
                  cart == 0 ? "" : cart.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                badgeColor: Colors.deepOrange,
                child: Icon(Icons.shopping_cart,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: BlocProvider(
        create: (context) => ItemDetailsScreenBloc(PostsRepastory())
          ..add(FetchItemDetailsScreen(widget.id)),
        child: BlocBuilder<ItemDetailsScreenBloc, ItemDetailsScreenState>(
          builder: (context, state) {
            print(widget.id.toString());

            if (state is ItemDetailsLoaded) {
              favList = state.idsFav;
              return Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Stack(children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: CarouselSlider.builder(
                              itemCount:
                                  state.itemData.items[0].photos.length == 0
                                      ? 1
                                      : state.itemData.items[0].photos.length,
                              height:
                                  (MediaQuery.of(context).size.height / 2) + 40,
                              viewportFraction: 1.0,
                              enableInfiniteScroll: true,
                              autoPlay: false,
                              aspectRatio: 2.0,
                              autoPlayInterval: Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              pauseAutoPlayOnTouch: Duration(seconds: 2),
                              enlargeCenterPage: true,
                              onPageChanged: (int index) {
                                setState(() {
                                  widget._current = index;
                                });
                              },
                              scrollDirection: Axis.horizontal,
                              itemBuilder:
                                  (BuildContext context, int itemIndex) =>
                                      ClipRRect(
                                borderRadius: BorderRadius.circular(0),
                                child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        child: Stack(
                                          children: [
                                            CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      2) +
                                                  40,
                                              imageUrl: state.itemData.items[0]
                                                          .photos.length ==
                                                      0
                                                  ? "s"
                                                  : imageUrl +
                                                      state
                                                          .itemData
                                                          .items[0]
                                                          .photos[
                                                              widget._current]
                                                          .photo,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      "assets/images/fashion.jpg",
                                                      fit: BoxFit.cover,
                                                      height: (MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              2) +
                                                          40,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/fashion.jpg",
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        2) +
                                                    40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // shape: RoundedRectangleBorder(
                                        //   borderRadius:
                                        //       BorderRadius.circular(0.0),
                                        // ),
                                        elevation: 0,
                                      ),
                                    )),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0.0,
                              child: Container(
                                margin: EdgeInsets.only(bottom: 20),
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: state.itemData.items[0].photos
                                      .map((image) {
                                    return Container(
                                      width: 12.0,
                                      height: 8.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: widget._current ==
                                                  state.itemData.items[0].photos
                                                      .indexOf(image)
                                              ? Colors.deepOrange
                                              : Colors.white),
                                    );
                                  }).toList(),
                                ),
                              )),
                          Positioned(
                              bottom: 0.0,
                              right: 10.0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final db = FavouritesDao(database);
                                      if (!favList.contains(
                                          state.itemData.items[0].id)) {
                                        await db.insertFav(Favourite(
                                            itemId: state.itemData.items[0].id,
                                            name: state.itemData.items[0].name,
                                            photo:
                                                state.itemData.items[0].photo,
                                            price:
                                                state.itemData.items[0].price));
                                        setState(() {
                                          favList
                                              .add(state.itemData.items[0].id);
                                        });
                                      } else {
                                        await db.deletFav(Favourite(
                                            itemId: state.itemData.items[0].id,
                                            name: state.itemData.items[0].name,
                                            photo:
                                                state.itemData.items[0].photo,
                                            price:
                                                state.itemData.items[0].price));
                                        setState(() {
                                          favList.remove(
                                              state.itemData.items[0].id);
                                        });
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(22.5)),
                                          color: Colors.white),
                                      width: 45,
                                      height: 45,
                                      child: Center(
                                          child: !favList.contains(
                                                  state.itemData.items[0].id)
                                              ? Icon(
                                                  Icons.favorite_border,
                                                  size: 25,
                                                )
                                              : Icon(
                                                  Icons.favorite,
                                                  size: 25,
                                                  color: Colors.red[600],
                                                )),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                            colors: [
                                              Theme.of(context)
                                                  .primaryColorDark,
                                              Theme.of(context)
                                                  .primaryColorLight
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter)),
                                    width: 60,
                                    height: 60,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: RaisedButton(
                                        color: Colors.transparent,
                                        child: Icon(
                                          Icons.add_shopping_cart,
                                          size: 25,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          print("pressed");
                                          _modalBottomSheetMenu(
                                              state.itemData.items[0]);
                                          // final db = CartItemsDao(database);
                                          // await db.insertItem(CartItem(
                                          //     itemId:
                                          //         state.itemData.items[0].id,
                                          //     name:
                                          //         state.itemData.items[0].name,
                                          //     photo:
                                          //         state.itemData.items[0].photo,
                                          //     size: state.itemData.items[0]
                                          //         .itemsize[0].itemsize,
                                          //     color: state.itemData.items[0]
                                          //         .itemcolor[0].color,
                                          //     price:
                                          //         state.itemData.items[0].price,
                                          //     number: 1,
                                          //     id: null));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ]),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 30),
                              child: Text(
                                state.itemData.items[0].createdAt
                                    .toString()
                                    .split(" ")[0],
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                state.itemData.items[0].name,
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "\$ " +
                                    state.itemData.items[0].price.toString(),
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(top: 20, right: 20),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    state.itemData.items[0].description
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            if (state is ItemDetailsScreenUninitialized) {
              return Center(
                child: Container(child: circularProgress()),
              );
            }
            if (state is ItemDetailsScreenNetworkError) {
              return networkError2("لا يوجد اتصال");
            }
            if (state is ItemDetailsScreenError) {
              return networkError2("حدث خطأ ما");
            }
          },
        ),
      )),
    );
  }

  void _modalBottomSheetMenu(Item item) {
    count = 0;
    color = "";
    size = "";
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 2,
            color: Colors.transparent,
            child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(30.0),
                        topRight: const Radius.circular(30.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      margin: EdgeInsets.only(top: 0),
                      elevation: 1,
                      child: Container(
                        color: Colors.grey[350],
                        width: 120,
                        height: 4,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    countWidget(context: context),
                    sizesWidget(
                        context: context,
                        sizes: item.itemsize.map((e) => e.itemsize).toList()),
                    colorsWidget(
                        context: context,
                        colors: item.itemcolor.map((e) => e.color).toList()),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColorLight,
                                Theme.of(context).primaryColorDark
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
                              print("pressed");
                              if (size != "" && color != "" && count != 0) {
                                final db = CartItemsDao(database);
                                await db.insertItem(CartItem(
                                    itemId: item.id,
                                    name: item.name,
                                    photo: item.photo,
                                    size: size,
                                    color: color,
                                    price: item.price * count,
                                    number: count,
                                    id: null));

                                Navigator.of(context).pop();
                                getCart();
                              } else if (size == "") {
                                Toast.show("يجب ان تختار حجم", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else if (color == "") {
                                Toast.show("يجب ان تختار لون", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              } else if (count == 0) {
                                Toast.show(
                                    "يجب ان تختار عدد ١ او اكثر", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            },
                            child: Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text(
                                  "أضافة إلى السلة",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                          )),
                    ),
                  ],
                )),
          );
        });
  }
}

class countWidget extends StatefulWidget {
  countWidget({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _countWidgetState createState() => _countWidgetState();
}

class _countWidgetState extends State<countWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: RaisedButton(
                color: Colors.transparent,
                child: Text(
                  "-",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                onPressed: () async {
                  print("pressed");

                  setState(() {
                    if (count > 0) {
                      count--;
                    }
                  });
                },
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              count.toString(),
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  Theme.of(context).primaryColorLight,
                  Theme.of(context).primaryColorDark
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            height: 50,
            width: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: RaisedButton(
                color: Colors.transparent,
                child: Text(
                  "+",
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                onPressed: () async {
                  print("pressed");

                  setState(() {
                    count++;
                  });
                  print("count  :" + count.toString());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class colorsWidget extends StatefulWidget {
  // Color selectedColor;
  // List<Color> colors = [Colors.red, Colors.amber, Colors.green];
  final List<String> colors;
  colorsWidget({Key key, @required this.context, this.colors})
      : super(key: key);

  final BuildContext context;

  @override
  _colorsWidgetState createState() => _colorsWidgetState();
}

class _colorsWidgetState extends State<colorsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "أختر اللون",
              style: TextStyle(color: Colors.black, fontSize: 22),
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 55,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ListView.builder(
                itemCount: widget.colors.length,
                shrinkWrap: true,
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                      color: getColorFromColorCode(widget.colors[index]),
                      //color: widget.color[index],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 55,
                    height: 55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RaisedButton(
                        elevation: 5,
                        color: Colors.transparent,
                        onPressed: () async {
                          setState(() {
                            color = widget.colors[index];
                          });
                        },
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: color != widget.colors[index]
                                ? Container()
                                : Icon(
                                    Icons.check,
                                    size: 25,
                                    color: Colors.white,
                                  )),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class sizesWidget extends StatefulWidget {
  final List<String> sizes;

  sizesWidget({Key key, @required this.context, this.sizes}) : super(key: key);

  final BuildContext context;

  @override
  _sizesWidgetState createState() => _sizesWidgetState();
}

class _sizesWidgetState extends State<sizesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              "أختر القياس",
              style: TextStyle(color: Colors.black, fontSize: 22),
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 55,
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ListView.builder(
                itemCount: widget.sizes.length,
                shrinkWrap: true,
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: size == widget.sizes[index]
                                ? [
                                    Theme.of(context).primaryColorLight,
                                    Theme.of(context).primaryColorDark
                                  ]
                                : [Colors.white, Colors.white],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight)),
                    height: 55,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RaisedButton(
                        color: Colors.transparent,
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              widget.sizes[index],
                              style: TextStyle(
                                  color: size == widget.sizes[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18),
                            )),
                        onPressed: () async {
                          print("pressed");

                          setState(() {
                            size = widget.sizes[index];
                            print(size);
                          });
                        },
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
