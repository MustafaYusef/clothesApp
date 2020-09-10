import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/itemsModel.dart';
import 'package:clothiesApp/utils/constant.dart';
import 'package:flutter/material.dart';

import '../itemDetailsScreen.dart';

class ItemCard extends StatelessWidget {
  Item data;
  int index;
  ItemCard({Key key, this.data, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Container(
                margin: EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          data.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            "IQ " + data.price.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColorDark),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            margin: EdgeInsets.all(2),
                            width: 85,
                            height: 30,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: RaisedButton(
                                color: Theme.of(context).primaryColorDark,
                                elevation: 5,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text("التفاصيل",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 500),
                                      pageBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double>
                                              secondaryAnimation) {
                                        return ItemDetailsScreen(data.id);
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
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Hero(
                transitionOnUserGestures: true,
                tag: "image$index",
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  width: 110,
                  height: 110,
                  imageUrl: imageUrl + data.photo,
                  placeholder: (context, url) => Image.asset(
                    "assets/images/placeholder.png",
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/images/placeholder.png",
                    fit: BoxFit.cover,
                    width: 110,
                    height: 110,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
