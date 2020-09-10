import 'dart:io';

import 'package:clothiesApp/database/database.dart';
import 'package:clothiesApp/models/categoryModel.dart';
import 'package:clothiesApp/models/itemsModel.dart';

import 'package:clothiesApp/models/offersModel.dart';
import 'package:clothiesApp/models/slidersModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

import '../main.dart';

abstract class FavouriteScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchFavouriteScreen extends FavouriteScreenEvent {
  FetchFavouriteScreen();

  @override
  List<Object> get props => [];
}

abstract class FavouriteScreenState extends Equatable {
  const FavouriteScreenState();

  @override
  List<Object> get props => [];
}

class FavouriteScreenUninitialized extends FavouriteScreenState {}

class FavouriteScreenError extends FavouriteScreenState {
  final string;
  FavouriteScreenError(this.string);
}

class FavouriteScreenNetworkError extends FavouriteScreenState {}

class FavouriteLoaded extends FavouriteScreenState {
  final List<Favourite> favDb;

  FavouriteLoaded(this.favDb);

  @override
  List<Object> get props => [favDb];
}

class FavouriteScreenBloc
    extends Bloc<FavouriteScreenEvent, FavouriteScreenState> {
  FavouriteScreenBloc() : super(FavouriteScreenUninitialized());

  @override
  Stream<Transition<FavouriteScreenEvent, FavouriteScreenState>>
      transformEvents(
    Stream<FavouriteScreenEvent> events,
    TransitionFunction<FavouriteScreenEvent, FavouriteScreenState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<FavouriteScreenState> mapEventToState(
      FavouriteScreenEvent event) async* {
    final currentState = state;

    if (event is FetchFavouriteScreen) {
      print("bloc pressed 111");
      try {
        yield FavouriteScreenUninitialized();
        final fav = await FavouritesDao(database).getAllFav();

        print(fav);
        yield FavouriteLoaded(fav);
        return;
      } on SocketException catch (_) {
        yield FavouriteScreenNetworkError();
      } catch (_) {
        yield FavouriteScreenError(_.toString());
      }
    }
  }
}
