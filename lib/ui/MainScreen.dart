import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothiesApp/blocs/MainBloc.dart';
import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/categoryModel.dart';
import 'package:clothiesApp/models/itemsModel.dart';
import 'package:clothiesApp/models/offersModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/itemDetailsScreen.dart';
import 'package:clothiesApp/ui/itemsScreen.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/mainScreenBody.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:clothiesApp/ui/uiComponent/sliderSection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../main.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

List<int> favList = [];

class _MainScreenState extends State<MainScreen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) {
        return MainScreenBloc(Repo: PostsRepastory())..add(FetchMainScreen());
      },
      child: Container(child: BlocBuilder<MainScreenBloc, MainScreenState>(
          builder: (context, state) {
        if (state is MainScreenLoading || state is MainScreenUninitialized) {
          return Center(
            child: Container(child: circularProgress()),
          );
        }
        if (state is MainScreenNetworkError) {
          return networkError2("لا يوجد اتصال");
        }
        if (state is MainScreenError) {
          return networkError2("حدث خطأ ما");
        }
        if (state is SliderLoaded) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  sliderSection(
                    current: _current,
                    banners: state.SliderData,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text(
                      "الأقسام",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return sectionCard();
                          }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "أخر العروض",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return sectionCard();
                          }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "المضاف حديثاً",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return sectionCard();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is CategoryLoaded) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  sliderSection(
                    current: _current,
                    banners: state.SliderData,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text(
                      "الأقسام",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: state.CategoryData.category.length,
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return sectionCard(
                              state.CategoryData.category[index]);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "أخر العروض",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: ListView.builder(
                          itemCount: 6,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return sectionCard();
                          }),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "المضاف حديثاً",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return sectionCard();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (state is OffersLoaded) {
          favList = state.favDb;
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  sliderSection(
                    current: _current,
                    banners: state.SliderData,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text(
                      "الأقسام",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: state.CategoryData.category.length,
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return sectionCard(
                              state.CategoryData.category[index]);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "أخر العروض",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: state.OffersData.offers.length,
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return offersCard(
                              state.OffersData.offers[index], favList);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "المضاف حديثاً",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[100],
                      enabled: true,
                      child: ListView.builder(
                          itemCount: 4,
                          shrinkWrap: true,
                          reverse: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return sectionCard();
                          }),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is LatestItemsLoaded) {
          favList = state.favDb;
          return SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  sliderSection(
                    current: _current,
                    banners: state.SliderData,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text(
                      "الأقسام",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: state.CategoryData.category.length,
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return sectionCard(
                              state.CategoryData.category[index]);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "أخر العروض",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: state.OffersData.offers.length,
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return offersCard(
                              state.OffersData.offers[index], favList);
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15, top: 15, bottom: 5),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        "المضاف حديثاً",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        itemCount: state.itemsModel.items.length,
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return LatestItemCard(
                              state.itemsModel.items[index], favList);
                        }),
                  ),
                ],
              ),
            ),
          );
        }
      })),
    ));
  }
}

class LatestItemCard extends StatefulWidget {
  Item offer;
  List<int> favDb;
  LatestItemCard(this.offer, this.favDb);

  @override
  _LatestItemCardState createState() => _LatestItemCardState();
}

class _LatestItemCardState extends State<LatestItemCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return ItemDetailsScreen(widget.offer.id);
        }));
      },
      child: Card(
        margin: EdgeInsets.all(7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 130,
                    height: 120,
                    imageUrl: widget.offer != null ? widget.offer.photo : "",
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.png",
                      width: 130,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/placeholder.png",
                      width: 130,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        final db = FavouritesDao(database);
                        if (!favList.contains(widget.offer.id)) {
                          await db.insertFav(Favourite(
                              itemId: widget.offer.id,
                              name: widget.offer.name,
                              photo: widget.offer.photo,
                              price: widget.offer.price));
                          setState(() {
                            favList.add(widget.offer.id);
                          });
                        } else {
                          await db.deletFav(Favourite(
                              itemId: widget.offer.id,
                              name: widget.offer.name,
                              photo: widget.offer.photo,
                              price: widget.offer.price));
                          setState(() {
                            favList.remove(widget.offer.id);
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white),
                        width: 35,
                        height: 35,
                        child: Center(
                            child: !favList.contains(widget.offer.id)
                                ? Icon(
                                    Icons.favorite_border,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.red[600],
                                  )),
                      ),
                    ))
              ],
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(widget.offer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                )),
            Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.only(right: 5, top: 5),
                  child: Text(
                    "\$ " + widget.offer.price.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class offersCard extends StatefulWidget {
  Offer offer;
  List<int> favDb;
  offersCard(this.offer, this.favDb);

  @override
  _offersCardState createState() => _offersCardState();
}

class _offersCardState extends State<offersCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // if (widget.offer != null) {
        //   Navigator.push(context, MaterialPageRoute(builder: (_) {
        //     return ItemDetailsScreen(widget.offer.id);
        //   }));
        // }
      },
      child: Card(
        margin: EdgeInsets.all(7),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: 130,
                    height: 120,
                    imageUrl: widget.offer != null ? widget.offer.photo : "",
                    placeholder: (context, url) => Image.asset(
                      "assets/images/placeholder.png",
                      width: 130,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/placeholder.png",
                      width: 130,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //     right: 0,
                //     child: InkWell(
                //       onTap: () async {
                //         await FavouritesDao(AppDatabase()).insertFav(Favourite(
                //           itemId: widget.offer.id,
                //           name: widget.offer.name,
                //           photo: widget.offer.photo,
                //           price: widget.offer.price,
                //         ));

                //         setState(() {
                //           favList.add(widget.offer.id);
                //         });
                //       },
                //       child: Container(
                //         margin: EdgeInsets.all(5),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.all(Radius.circular(20)),
                //             color: Colors.white),
                //         width: 35,
                //         height: 35,
                //         child: Center(
                //             child: !favList.contains(widget.offer.id)
                //                 ? Icon(
                //                     Icons.favorite_border,
                //                   )
                //                 : Icon(
                //                     Icons.favorite,
                //                     color: Colors.red[600],
                //                   )),
                //       ),
                //     ))
              ],
            ),
            Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: 130,
                  padding: const EdgeInsets.only(right: 5),
                  child: Text(widget.offer.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      )),
                )),
            Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  margin: EdgeInsets.only(right: 5, top: 5),
                  child: Text(
                    "\$ " + widget.offer.price.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class sectionCard extends StatelessWidget {
  Category category;
  sectionCard([this.category]);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (category != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ItemsScreen(category);
          }));
        }
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(
          children: [
            CachedNetworkImage(
              fit: BoxFit.cover,
              width: 120,
              imageUrl: category != null ? category.photo : "",
              placeholder: (context, url) => Image.asset(
                "assets/images/placeholder.png",
                width: 130,
                height: 120,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/placeholder.png",
                width: 130,
                height: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Directionality(
                      child: Text(
                        category != null ? category.name : "",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0.5,
                        1
                      ],
                      colors: [
                        Colors.black26.withOpacity(0.5),
                        Colors.transparent
                      ])),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        margin: EdgeInsets.all(7),
      ),
    );
//     return Card(

//       elevation: 5,
//       child: Container(
//           margin: EdgeInsets.only(left: 5, right: 5),
//           child: Stack(
//             children: <Widget>[
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: CachedNetworkImage(
//                   fit: BoxFit.cover,
//                   width: 100,
//                   imageUrl: category.photo,
//                   placeholder: (context, url) =>
//                       Image.asset("assets/images/placeholder.png"),
//                   errorWidget: (context, url, error) =>
//                       Image.asset("assets/images/placeholder.png"),
//                 ),
// //                        FadeInImage(
// //                          placeholder:
// //                              AssetImage("assets/images/placeholder.png"),
// //                          fit: BoxFit.cover,
// //                          width: MediaQuery.of(context).size.width,
// //                          height: 240,
// //                          image: NetworkImage(
// //                              baseUrlImage + widget.packages[itemIndex].file),
// //                        ),
//               ),
//               Container(
//                 width: 120,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(
//                           color: Colors.lightBlue[900],
//                           borderRadius: BorderRadius.circular(10)),
//                       padding: EdgeInsets.all(5),
//                       child: Directionality(
//                         child: Text(
//                           category.name,
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                         textDirection: TextDirection.rtl,
//                       ),
//                     ),

//                   ],
//                 ),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10)),
//                     gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         stops: [
//                           0.1,
//                           0.5
//                         ],
//                         colors: [
//                           Colors.black26.withOpacity(0.7),
//                           Colors.transparent
//                         ])),
//               ),
//             ],
//           )),
//     );
  }
}
