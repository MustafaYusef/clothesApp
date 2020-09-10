import 'dart:io';

import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/itemsModel.dart';
import 'package:clothiesApp/models/orderItemsModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ItemsScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchItemsScreen extends ItemsScreenEvent {
  final int id;
  FetchItemsScreen(this.id);

  @override
  List<Object> get props => [id];
}

class FetchOrderItemsScreen extends ItemsScreenEvent {
  final int id;
  FetchOrderItemsScreen(this.id);

  @override
  List<Object> get props => [id];
}

abstract class ItemsScreenState extends Equatable {
  const ItemsScreenState();

  @override
  List<Object> get props => [];
}

class ItemsScreenUninitialized extends ItemsScreenState {}

class ItemsScreenError extends ItemsScreenState {
  final string;
  ItemsScreenError(this.string);
}

class ItemsScreenNetworkError extends ItemsScreenState {}

class ItemsLoaded extends ItemsScreenState {
  final ItemsModel itemData;

  ItemsLoaded(this.itemData);

  @override
  List<Object> get props => [itemData];
}
class ItemsOrderLoaded extends ItemsScreenState {
  final OrderItemsModel items;

  ItemsOrderLoaded(this.items);

  @override
  List<Object> get props => [items];
}
class ItemsScreenBloc extends Bloc<ItemsScreenEvent, ItemsScreenState> {
  final PostsRepastory repo;
  ItemsScreenBloc(this.repo) : super(ItemsScreenUninitialized());

  @override
  Stream<Transition<ItemsScreenEvent, ItemsScreenState>> transformEvents(
    Stream<ItemsScreenEvent> events,
    TransitionFunction<ItemsScreenEvent, ItemsScreenState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ItemsScreenState> mapEventToState(ItemsScreenEvent event) async* {
    final currentState = state;

    if (event is FetchItemsScreen) {
      print("bloc pressed");
      try {
        if (currentState is ItemsScreenUninitialized) {
          final items = await repo.getItemsByCategory(event.id);
          print(items);
          yield ItemsLoaded(items);
          return;
        }
      } on SocketException catch (_) {
        yield ItemsScreenNetworkError();
      } catch (_) {
        yield ItemsScreenError(_.toString());
      }
    } else if (event is FetchOrderItemsScreen) {
      print("bloc pressed");
      try {
        yield ItemsScreenUninitialized();
           SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = await prefs.getString('token');
        final items = await repo.getorderItems(token,event.id);
        print(items);
        yield ItemsOrderLoaded(items);
        return;
      } on SocketException catch (_) {
        yield ItemsScreenNetworkError();
      } catch (_) {
        yield ItemsScreenError(_.toString());
      }
    }
  }
}
