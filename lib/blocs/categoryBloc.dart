import 'dart:io';

import 'package:clothiesApp/models/categoryModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';

abstract class CategoryScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchCategoryScreen extends CategoryScreenEvent {
  FetchCategoryScreen();

  @override
  List<Object> get props => [];
}

abstract class CategoryScreenState extends Equatable {
  const CategoryScreenState();

  @override
  List<Object> get props => [];
}

class CategoryScreenUninitialized extends CategoryScreenState {}

class CategoryScreenError extends CategoryScreenState {
  final string;
  CategoryScreenError(this.string);
}

class CategoryScreenNetworkError extends CategoryScreenState {}

class CategoryLoaded extends CategoryScreenState {
  final CatagoryModel category;

  CategoryLoaded(this.category);

  @override
  List<Object> get props => [category];
}

class CategoryScreenBloc
    extends Bloc<CategoryScreenEvent, CategoryScreenState> {
  final PostsRepastory repo;
  CategoryScreenBloc(this.repo) : super(CategoryScreenUninitialized());

  @override
  Stream<Transition<CategoryScreenEvent, CategoryScreenState>> transformEvents(
    Stream<CategoryScreenEvent> events,
    TransitionFunction<CategoryScreenEvent, CategoryScreenState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<CategoryScreenState> mapEventToState(
      CategoryScreenEvent event) async* {
    final currentState = state;

    if (event is FetchCategoryScreen) {
      print("bloc pressed");
      try {
        if (currentState is CategoryScreenUninitialized) {
          final Category = await repo.getCategory();
          print(Category);
          yield CategoryLoaded(Category);
          return;
        }
      } on SocketException catch (_) {
        yield CategoryScreenNetworkError();
      } catch (_) {
        yield CategoryScreenError(_.toString());
      }
    }
  }
}
