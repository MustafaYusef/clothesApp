import 'dart:convert';

import 'package:clothiesApp/models/categoryModel.dart';
import 'package:clothiesApp/models/itemDetailsModel.dart';
import 'package:clothiesApp/models/itemsModel.dart';
import 'package:clothiesApp/models/loginRes.dart';
import 'package:clothiesApp/models/offersModel.dart';
import 'package:clothiesApp/models/orderErrorModel.dart';
import 'package:clothiesApp/models/orderItemsModel.dart';

import 'package:clothiesApp/models/orderModel.dart';
import 'package:clothiesApp/models/profileModel.dart';
import 'package:clothiesApp/models/regesterRes.dart';
import 'package:clothiesApp/models/slidersModel.dart';
import 'package:clothiesApp/utils/constant.dart';
import 'package:http/http.dart';

class PostsRepastory {
  Future<SlidersModel> getSliders() async {
    final response = await get(baseUrl + "slider/getSlider");
    if (response.statusCode == 200) {
      return SlidersModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<OffersModel> getOffers() async {
    final response = await get(baseUrl + "offers/getOffers");
    if (response.statusCode == 200) {
      return OffersModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<CatagoryModel> getCategory() async {
    final response = await get(baseUrl + "category/getcategory");
    if (response.statusCode == 200) {
      return CatagoryModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ItemsModel> getLatestItem() async {
    final response = await get(baseUrl + "items/getlatestitems");
    if (response.statusCode == 200) {
      return ItemsModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ItemsModel> getItemsByCategory(int id) async {
    final response = await get(baseUrl + "items/getitems?CategoryID=$id");
    if (response.statusCode == 200) {
      return ItemsModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ItemDetailsModel1> getDetailsItems(int id) async {
    final response = await get(baseUrl + "items/phoneItemDetail?id=$id");
    if (response.statusCode == 200) {
      return ItemDetailsModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<ProfileModel> getProfile(String token) async {
    final response = await get(baseUrl + "profile/getProfile",
        headers: {"Authorization": token});
    if (response.statusCode == 200) {
      return ProfileModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<LoginRes> login(String name, String pass) async {
    final response = await post(baseUrl + "users/login",
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": name, "password": pass}));
    if (response.statusCode == 200) {
      return LoginResFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<RegesterResModel> regester(
      String name, String pass, String phone, String location) async {
    final response = await post(baseUrl + "users/register",
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "username": name,
          "password": pass,
          "phonenumber": phone,
          "location": location
        }));
    if (response.statusCode == 200) {
      return RegesterResModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<RegesterResModel> changePassword(
      String oldPass, String newPass, String token) async {
    final response = await put(baseUrl + "users/changepassword",
        headers: {"Content-Type": "application/json", "Authorization": token},
        body: json.encode({"oldpassword": oldPass, "newpassword": newPass}));
    if (response.statusCode == 200) {
      return RegesterResModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<OrdersModel> getOrder(String token) async {
    final response = await get(baseUrl + "order/userorders",
        headers: {"Content-Type": "application/json", "Authorization": token});
    if (response.statusCode == 200) {
      return OrdersModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<OrderItemsModel> getorderItems(String token,int id) async {
    final response = await get(baseUrl + "order/getorderitems?orderid=$id",
        headers: {"Content-Type": "application/json", "Authorization": token},
        );
    if (response.statusCode == 200) {
      return orderItemsModelFromJson(response.body);
    } else {
      throw Exception('حدث خطأ ما');
    }
  }

  Future<RegesterResModel> makeOrder(
      String token,
      List<int> itemsid,
      List<int> counts,
      int totalptice,
      List<String> colors,
      List<String> sizes,
      int userId) async {
    final response = await post(baseUrl + "order/addorder",
        headers: {"Authorization": token, "Content-Type": "application/json"},
        body: json.encode({
          "itemid": itemsid,
          "count": counts,
          "color": colors,
          "totalptice": totalptice,
          "size": sizes,
          "userid": userId
        }));
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RegesterResModelFromJson(response.body);
    } else {
      print(errorModelFromJson(response.body).error);
      throw Exception(errorModelFromJson(response.body).error);
    }
  }
}

//
