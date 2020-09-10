import 'dart:io';

import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/main.dart';
import 'package:clothiesApp/models/orderModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/orderScreen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

abstract class OrderScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchOrder extends OrderScreenEvent {
  FetchOrder();

  @override
  List<Object> get props => [];
}

class FetchOrderItems extends OrderScreenEvent {
  final int orderId;
  FetchOrderItems(this.orderId);

  @override
  List<Object> get props => [orderId];
}

abstract class OrderScreenState extends Equatable {
  const OrderScreenState();

  @override
  List<Object> get props => [];
}

class OrderScreenUninitialized extends OrderScreenState {}

class OrderScreenError extends OrderScreenState {
  final string;
  OrderScreenError(this.string);
}

class OrdersLoaded extends OrderScreenState {
  final OrdersModel orders;

  OrdersLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}
class OrderItemsLoaded extends OrderScreenState {
  final OrdersModel orders;

  OrderItemsLoaded(this.orders);

  @override
  List<Object> get props => [orders];
}
class OrderScreenNetworkError extends OrderScreenState {}

class OrderScreenBloc extends Bloc<OrderScreenEvent, OrderScreenState> {
  final PostsRepastory repo;
  OrderScreenBloc(this.repo) : super(OrderScreenUninitialized());

  @override
  Stream<Transition<OrderScreenEvent, OrderScreenState>> transformEvents(
    Stream<OrderScreenEvent> events,
    TransitionFunction<OrderScreenEvent, OrderScreenState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<OrderScreenState> mapEventToState(OrderScreenEvent event) async* {
    final currentState = state;

    if (event is FetchOrder) {
      print("bloc pressed");
      try {
        // yield LoginScreenLoading();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = await prefs.getString('token');
        print(token);
        final orders = await repo.getOrder(token);
        print(orders.orders.length);
        yield OrdersLoaded(orders);
        return;
      } on SocketException catch (_) {
        yield OrderScreenError(_.toString());
      } catch (_) {
        yield OrderScreenNetworkError();
      }
    }
  }
}
