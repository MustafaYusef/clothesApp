import 'dart:io';

import 'package:clothiesApp/models/profileModel.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/Auth/loginScreen.dart';
import 'package:clothiesApp/ui/ProfileScreen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../main.dart';

abstract class LoginScreenEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProfileScreen extends LoginScreenEvent {
  BuildContext context;
  FetchProfileScreen(this.context);

  @override
  List<Object> get props => [context];
}

class FetchLoginScreen extends LoginScreenEvent {
  final String username;
  final String password;
  final BuildContext context;
  FetchLoginScreen(this.username, this.password, this.context);

  @override
  List<Object> get props => [username, password, context];
}

class FetchChangePassScreen extends LoginScreenEvent {
  final String oldPass;
  final String newPass;
  final BuildContext context;
  FetchChangePassScreen(this.oldPass, this.newPass, this.context);

  @override
  List<Object> get props => [oldPass, newPass, context];
}

class FetchRegesterScreen extends LoginScreenEvent {
  final String username;
  final String password;
  final String location;
  final String phone;
  final BuildContext context;
  FetchRegesterScreen(
      this.username, this.password, this.location, this.phone, this.context);

  @override
  List<Object> get props => [username, password, location, phone, context];
}

abstract class LoginScreenState extends Equatable {
  const LoginScreenState();

  @override
  List<Object> get props => [];
}

class LoginScreenUninitialized extends LoginScreenState {}

class LoginScreenLoading extends LoginScreenState {}

class LoginScreenError extends LoginScreenState {
  final string;
  LoginScreenError(this.string);
}

class LoginScreenNetworkError extends LoginScreenState {}

class LoginLoaded extends LoginScreenState {
  LoginLoaded();

  @override
  List<Object> get props => [];
}

class ProfileLoaded extends LoginScreenState {
  final ProfileModel profile;
  ProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class ChangePassLoaded extends LoginScreenState {
  ChangePassLoaded();

  @override
  List<Object> get props => [];
}

class RegesterLoaded extends LoginScreenState {
  RegesterLoaded();

  @override
  List<Object> get props => [];
}

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final PostsRepastory repo;
  LoginScreenBloc(this.repo) : super(LoginScreenUninitialized());

  @override
  Stream<Transition<LoginScreenEvent, LoginScreenState>> transformEvents(
    Stream<LoginScreenEvent> events,
    TransitionFunction<LoginScreenEvent, LoginScreenState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
    final currentState = state;

    if (event is FetchLoginScreen) {
      print("bloc pressed");
      try {
        yield LoginScreenLoading();
        final login = await repo.login(event.username, event.password);
        Toast.show("تم التسجيل بنجاح", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('token', "bariar " + login.token);
        String token = await prefs.getString('token');
        print("token    :" + token);

        Navigator.of(event.context)
            .pushReplacement(MaterialPageRoute(builder: (_) {
          return Main(0);
        }));
        return;
      } on SocketException catch (_) {
        Toast.show("لا يوجد اتصال بالشبكة", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
      } catch (_) {
        Toast.show("يوجد خطأ في كلمة المرور", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
      }
    } else if (event is FetchRegesterScreen) {
      try {
        yield LoginScreenLoading();
        final regester = await repo.regester(
            event.username, event.password, event.phone, event.location);
        Toast.show("تم أنشاء حساب بنجاح", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
        Navigator.of(event.context)
            .pushReplacement(MaterialPageRoute(builder: (_) {
          return LoginScreen();
        }));
        yield LoginScreenUninitialized();
        return;
      } on SocketException catch (_) {
        Toast.show("لا يوجد اتصال بالشبكة", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
      } catch (_) {
        Toast.show("يوجد خطأ في كلمة المرور", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
      }
    } else if (event is FetchChangePassScreen) {
      try {
        yield LoginScreenLoading();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = await prefs.getString('token');
        final changePass =
            await repo.changePassword(event.oldPass, event.oldPass, token);
        Toast.show("تم تغيير كلمة المرور بنجاح", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
        Navigator.of(event.context).pop();
        return;
      } on SocketException catch (_) {
        Toast.show("لا يوجد اتصال بالشبكة", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
      } catch (_) {
        Toast.show("يوجد خطأ في كلمة المرور", event.context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        yield LoginScreenUninitialized();
      }
    } else if (event is FetchProfileScreen) {
      try {
        yield LoginScreenUninitialized();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = await prefs.getString('token');
        if (token == null || token == "") {
          Toast.show("يجب عليك تسجيل الدخول", event.context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          Navigator.of(event.context)
              .pushReplacement(MaterialPageRoute(builder: (_) {
            return LoginScreen();
          }));
        }

        final profile = await repo.getProfile(token);

        await prefs.setInt('userId', profile.profile.id);
        var userid = await prefs.getInt("userId");
        print("user id   :" + userid.toString());
        yield ProfileLoaded(profile);
        return;
      } on SocketException catch (_) {
        yield LoginScreenNetworkError();
      } catch (_) {
        yield LoginScreenError(_.toString());
      }
    }
  }
}
