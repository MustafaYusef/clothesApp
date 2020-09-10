import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/ui/itemDetailsScreen.dart';
import 'package:clothiesApp/utils/constant.dart';
import 'package:flutter/material.dart';

class CartItemsCard extends StatelessWidget {
  CartItem data;

  CartItemsCard({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return ItemDetailsScreen(data.itemId);
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
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 62,
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RaisedButton(
                        color: Colors.grey[300],
                        elevation: 5,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(data.size,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 500),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return ItemDetailsScreen(data.itemId);
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
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 62,
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: RaisedButton(
                        color: getColorFromColorCode(data.color),
                        elevation: 5,
                        child: Center(
                            child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        )),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Directionality(
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
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                "IQ " + data.price.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColorDark),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
            ],
          ),
        ),
      ),
    );
  }
}

Color getColorFromColorCode(String code) {
  return code.length < 7
      ? Colors.white
      : Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
