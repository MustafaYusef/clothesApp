import 'package:cached_network_image/cached_network_image.dart';
import 'package:clothiesApp/blocs/categoryBloc.dart';
import 'package:clothiesApp/models/categoryModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/itemsScreen.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:clothiesApp/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SectionsScreen extends StatefulWidget {
  SectionsScreen({Key key}) : super(key: key);

  @override
  _SectionsScreenState createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) =>
            CategoryScreenBloc(PostsRepastory())..add(FetchCategoryScreen()),
        child: BlocBuilder<CategoryScreenBloc, CategoryScreenState>(
          builder: (context, state) {
            if (state is CategoryLoaded) {
              return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ResponsiveGridList(
                      desiredItemWidth:
                          (MediaQuery.of(context).size.width / 2) - 10,
                      minSpacing: 5,
                      children: state.category.category.map((data) {
                        return sectionCard(data);
                      }).toList()));
            }
            if (state is CategoryScreenUninitialized) {
              return Center(
                child: Container(child: circularProgress()),
              );
            }
            if (state is CategoryScreenError) {
              return networkError2("لا يوجد اتصال");
            }
            if (state is CategoryScreenNetworkError) {
              return networkError2("حدث خطأ ما");
            }
          },
        ),
      ),
    );
  }
}

class sectionCard extends StatelessWidget {
  Category data;
  sectionCard(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ItemsScreen(data);
          }));
        },
        child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: CachedNetworkImage(
                    width: 300,
                    height: 150,
                    fit: BoxFit.fill,
                    imageUrl: imageUrl + data.photo,
                    placeholder: (context, url) => Image.asset(
                      "assets/images/sec1.png",
                      width: 300,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                      "assets/images/sec1.png",
                      width: 300,
                      height: 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      data.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
