import 'dart:io';

import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/categoryModel.dart';
import 'package:clothiesApp/models/itemsModel.dart';

import 'package:clothiesApp/models/offersModel.dart';
import 'package:clothiesApp/models/slidersModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/orderScreen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../main.dart';

abstract class CartScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCartScreen extends CartScreenEvent {
  FetchCartScreen();

  @override
  List<Object> get props => [];
}

class MakeOrder extends CartScreenEvent {
  final BuildContext context;
  MakeOrder({this.context});

  @override
  List<Object> get props => [context];
}

abstract class CartScreenState extends Equatable {
  const CartScreenState();

  @override
  List<Object> get props => [];
}

class CartScreenUninitialized extends CartScreenState {}

class MakeOrderLoading extends CartScreenState {}

class CartScreenError extends CartScreenState {
  final string;
  CartScreenError(this.string);
}

class CartScreenNetworkError extends CartScreenState {}

class CartLoaded extends CartScreenState {
  final List<CartItem> favDb;

  CartLoaded(this.favDb);

  @override
  List<Object> get props => [favDb];
}

class CartScreenBloc extends Bloc<CartScreenEvent, CartScreenState> {
  final PostsRepastory repo;

  CartScreenBloc({this.repo}) : super(CartScreenUninitialized());

  @override
  Stream<Transition<CartScreenEvent, CartScreenState>> transformEvents(
    Stream<CartScreenEvent> events,
    TransitionFunction<CartScreenEvent, CartScreenState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<CartScreenState> mapEventToState(CartScreenEvent event) async* {
    final currentState = state;

    if (event is FetchCartScreen) {
      print("bloc pressed 111");
      try {
        final fav = await CartItemsDao(database).getAllItems();

        print(fav);
        yield CartLoaded(fav);
        return;
      } on SocketException catch (_) {
        yield CartScreenNetworkError();
      } catch (_) {
        yield CartScreenError(_.toString());
      }
    } else if (event is MakeOrder) {
      print("bloc pressed make order");
      try {
        if (currentState is CartLoaded) {
          //yield MakeOrderLoading();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          String token = await prefs.getString('token');
          int userId = await prefs.getInt("userId");
          print(userId);
          final totalPrice =
              getTotal(currentState.favDb.map((e) => e.price).toList());
          final List<int> itemIds =
              currentState.favDb.map((e) => e.itemId).toList();
          final List<int> counts =
              currentState.favDb.map((e) => e.number).toList();
          final List<String> colors =
              currentState.favDb.map((e) => e.color).toList();
          final List<String> sizes =
              currentState.favDb.map((e) => e.size).toList();

          final oredr = await repo.makeOrder(
              token, itemIds, counts, totalPrice, colors, sizes, userId);
          await CartItemsDao(database).deletAllItem();
          Toast.show("تم أرسال طلبك بنجاح", event.context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.of(event.context)
              .pushReplacement(MaterialPageRoute(builder: (_) {
            return OrderScreen();
          }));

          // yield CartScreenUninitialized();
          return;
        }
      } on SocketException catch (_) {
        Toast.show("لا يوجد اتصال بالشبكة", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      } catch (_) {
        print(_.toString());
        Toast.show(_.toString() + "j djhj jdjb jbd", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    }
  }

  int getTotal([List<int> list]) {
    int sum = 0;
    for (var item in list) {
      sum += item;
    }
    return sum;
  }
}
