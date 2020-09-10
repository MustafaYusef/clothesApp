import 'package:clothiesApp/blocs/authBloc.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/Auth/changePassword.dart';
import 'package:clothiesApp/ui/Auth/loginScreen.dart';
import 'package:clothiesApp/ui/orderScreen.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:clothiesApp/ui/uiComponent/networkError2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return LoginScreenBloc(PostsRepastory())
          ..add(FetchProfileScreen(context));
      },
      child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
          builder: (context, state) {
        if (state is LoginScreenUninitialized) {
          return Center(
            child: Container(child: circularProgress()),
          );
        }
        if (state is ProfileLoaded) {
          return Container(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              state.profile.profile.username,
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColorDark,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              state.profile.profile.phone,
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.phone,
                          color: Theme.of(context).primaryColorDark,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              state.profile.profile.address,
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.pin_drop,
                          color: Theme.of(context).primaryColorDark,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return OrderScreen();
                    }));
                  },
                  child: Card(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                "طلباتي",
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.local_offer,
                            color: Theme.of(context).primaryColorDark,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return ChangePasswordScreen();
                            }));
                          },
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColorDark,
                            size: 25,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: 10,
                          ),
                        ),
                        Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              "تغيير كلمة المرور",
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColorDark,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (_) {
                      return LoginScreen();
                    }));
                  },
                  child: Card(
                    margin: EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text(
                                "تسجيل الخروج",
                                style: TextStyle(fontSize: 20),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.screen_lock_rotation,
                            color: Theme.of(context).primaryColorDark,
                            size: 25,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        if (state is LoginScreenNetworkError) {
          return networkError2("لا يوجد اتصال");
        }
        if (state is LoginScreenError) {
          return networkError2("حدث خطأ ما");
        }
      }),
    );
  }
}
