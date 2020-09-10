import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:clothiesApp/models/slidersModel.dart';
import 'package:clothiesApp/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sliderSection extends StatefulWidget {
  sliderSection({
    Key key,
    @required int current,
    @required this.banners,
  })  : _current = current,
        super(key: key);

  int _current;
  SlidersModel banners;
  @override
  _sliderSectionState createState() => _sliderSectionState();
}

class _sliderSectionState extends State<sliderSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
        CarouselSlider.builder(
          itemCount: widget.banners.slider.length == 0
              ? 1
              : widget.banners.slider.length,
          height: 200,
          viewportFraction: 1.0,
          enableInfiniteScroll: true,
          autoPlay: true,
          aspectRatio: 2.0,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: Duration(seconds: 2),
          enlargeCenterPage: true,
          onPageChanged: (int index) {
            setState(() {
              widget._current = index;
            });
          },
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int itemIndex) => ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: [
                        CachedNetworkImage(
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          imageUrl: imageUrl +
                              widget.banners.slider[widget._current].photo,
                          placeholder: (context, url) =>
                              Image.asset("assets/images/placeholder.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/placeholder.png"),
                        ),
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5,
                  ),
                )),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(2),
        //   child: widget.banners.data.length == 0
        //       ? Container()
        //       : Positioned(
        //           bottom: 0.0,
        //           child: Row(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: widget.banners.data.map((image) {
        //               return Container(
        //                 width: 8.0,
        //                 height: 8.0,
        //                 margin: EdgeInsets.symmetric(
        //                     vertical: 10.0, horizontal: 2.0),
        //                 decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     color: widget._current ==
        //                             widget.banners.data.indexOf(image)
        //                         ? Colors.deepOrange
        //                         : Color.fromRGBO(0, 0, 0, 0.4)),
        //               );
        //             }).toList(),
        //           )),
        // )
      ]),
    );
  }
}
