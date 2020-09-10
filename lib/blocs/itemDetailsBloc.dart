import 'dart:io';

import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/itemDetailsModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

import '../main.dart';

abstract class ItemDetailsScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchItemDetailsScreen extends ItemDetailsScreenEvent {
  final int id;
  FetchItemDetailsScreen(this.id);

  @override
  List<Object> get props => [id];
}

abstract class ItemDetailsScreenState extends Equatable {
  const ItemDetailsScreenState();

  @override
  List<Object> get props => [];
}

class ItemDetailsScreenUninitialized extends ItemDetailsScreenState {}

class ItemDetailsScreenError extends ItemDetailsScreenState {
  final string;
  ItemDetailsScreenError(this.string);
}

class ItemDetailsScreenNetworkError extends ItemDetailsScreenState {}

class ItemDetailsLoaded extends ItemDetailsScreenState {
  final ItemDetailsModel1 itemData;
  final List<int> idsFav;
  ItemDetailsLoaded(this.itemData, this.idsFav);

  @override
  List<Object> get props => [itemData];
}

class ItemDetailsScreenBloc
    extends Bloc<ItemDetailsScreenEvent, ItemDetailsScreenState> {
  final PostsRepastory repo;
  ItemDetailsScreenBloc(this.repo) : super(ItemDetailsScreenUninitialized());

  @override
  Stream<Transition<ItemDetailsScreenEvent, ItemDetailsScreenState>>
      transformEvents(
    Stream<ItemDetailsScreenEvent> events,
    TransitionFunction<ItemDetailsScreenEvent, ItemDetailsScreenState>
        transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<ItemDetailsScreenState> mapEventToState(
      ItemDetailsScreenEvent event) async* {
    final currentState = state;

    if (event is FetchItemDetailsScreen) {
      print("bloc pressed item");
      try {
        if (currentState is ItemDetailsScreenUninitialized) {
          final ItemDetailsModel1 itemDetails =
              await repo.getDetailsItems(event.id);
          final favourite = await FavouritesDao(database).getAllFav();
          print(favourite);
          List<int> idsFav = [];
          for (var a in favourite) {
            idsFav.add(a.itemId);
          }
          print(itemDetails);
          yield ItemDetailsLoaded(itemDetails, idsFav);
          return;
        }
      } on SocketException catch (_) {
        yield ItemDetailsScreenNetworkError();
      } catch (_) {
        yield ItemDetailsScreenError(_.toString());
      }
    }
  }
}
