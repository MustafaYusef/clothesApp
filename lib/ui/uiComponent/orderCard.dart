import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/orderModel.dart';
import 'package:clothiesApp/ui/itemDetailsScreen.dart';
import 'package:clothiesApp/ui/orderItemsScreen.dart';
import 'package:clothiesApp/utils/colorselect.dart';
import 'package:clothiesApp/utils/constant.dart';
import 'package:clothiesApp/utils/time.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  OrderCard(this.order, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) {
          return OrderItemsScreen(order.id);
        }));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    width: 100,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: RaisedButton(
                        color: getListColor(order.state),
                        elevation: 5,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(getStatus(order.state),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
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
                              getDate(order.createdAt.toString()),
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    "IQ " + order.totalptice.toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).primaryColorDark),
                                  )),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text("السعر الكلي: ",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
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
