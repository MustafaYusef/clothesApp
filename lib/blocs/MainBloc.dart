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

abstract class MainScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchMainScreen extends MainScreenEvent {
  int p;
  bool flage;

  FetchMainScreen({this.p, this.flage});

  @override
  List<Object> get props => [p, flage];
}

abstract class MainScreenState extends Equatable {
  const MainScreenState();

  @override
  List<Object> get props => [];
}

class MainScreenUninitialized extends MainScreenState {}

class MainScreenLoading extends MainScreenState {}

class MainScreenError extends MainScreenState {
  final string;
  MainScreenError(this.string);
}

class MainScreenNetworkError extends MainScreenState {}

class SliderLoaded extends MainScreenState {
  final SlidersModel SliderData;

  SliderLoaded({this.SliderData});

  @override
  List<Object> get props => [SliderData];
}

class CategoryLoaded extends MainScreenState {
  final CatagoryModel CategoryData;
  final SlidersModel SliderData;

  CategoryLoaded({this.CategoryData, this.SliderData});

  @override
  List<Object> get props => [CategoryData, SlidersModel];
}

class OffersLoaded extends MainScreenState {
  final OffersModel OffersData;
  final CatagoryModel CategoryData;
  final SlidersModel SliderData;
  final List<int> favDb;
  OffersLoaded(
      {this.OffersData, this.CategoryData, this.SliderData, this.favDb});

  @override
  List<Object> get props => [OffersData, CategoryData, SliderData, favDb];
}

class LatestItemsLoaded extends MainScreenState {
  final OffersModel OffersData;
  final CatagoryModel CategoryData;
  final SlidersModel SliderData;
  final ItemsModel itemsModel;
  final List<int> favDb;
  LatestItemsLoaded(
      {this.OffersData,
      this.CategoryData,
      this.SliderData,
      this.itemsModel,
      this.favDb});

  @override
  List<Object> get props =>
      [OffersData, CategoryData, SliderData, itemsModel, favDb];
}

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final PostsRepastory Repo;

  MainScreenBloc({@required this.Repo}) : super(MainScreenUninitialized());

  @override
  Stream<Transition<MainScreenEvent, MainScreenState>> transformEvents(
    Stream<MainScreenEvent> events,
    TransitionFunction<MainScreenEvent, MainScreenState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
    final currentState = state;

    if (event is FetchMainScreen) {
      print("bloc pressed");
      try {
        if (currentState is MainScreenUninitialized) {
          final slider = await Repo.getSliders();
          yield SliderLoaded(SliderData: slider);
          final category = await Repo.getCategory();
          yield CategoryLoaded(CategoryData: category, SliderData: slider);

          final offers = await Repo.getOffers();

          final favourite = await FavouritesDao(database).getAllFav();
          print(favourite);
          List<int> idsFav = [];
          for (var a in favourite) {
            idsFav.add(a.itemId);
          }

          yield OffersLoaded(
              CategoryData: category,
              SliderData: slider,
              OffersData: offers,
              favDb: idsFav);
          final latest = await Repo.getLatestItem();
          yield LatestItemsLoaded(
              CategoryData: category,
              SliderData: slider,
              OffersData: offers,
              itemsModel: latest,
              favDb: idsFav);
          return;
        }
      } on SocketException catch (_) {
        yield MainScreenNetworkError();
      } catch (_) {
        print(_.toString());
        yield MainScreenError(_.toString());
      }
    }
  }
}
