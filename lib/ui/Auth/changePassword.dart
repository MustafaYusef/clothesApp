import 'package:clothiesApp/blocs/authBloc.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/Auth/loginScreen.dart';
import 'package:clothiesApp/ui/ProfileScreen.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController oldPass = TextEditingController();
  TextEditingController newPass = TextEditingController();
  bool flage1 = true;
  bool flage2 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColorDark),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Directionality(
            textDirection: TextDirection.rtl,
            child: Text("تسجيل الدخول",
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          return LoginScreenBloc(PostsRepastory());
        },
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Directionality(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.blueAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: TextField(
                          controller: oldPass,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(fontSize: 20),
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              hoverColor: Colors.amber,
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "",
                              alignLabelWithHint: true,
                              labelText: "كلمة المرور القديمة",
                              hasFloatingPlaceholder: true,
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  backgroundColor: Colors.transparent,
                                  decorationColor: Colors.transparent),
                              prefixIcon: const Icon(Icons.lock),
                              suffix: Container(
                                height: 40,
                                child: IconButton(
                                  icon: flage1
                                      ? Icon(
                                          Icons.visibility_off,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          size: 20,
                                        ),
                                  color: Colors.blueAccent,
                                  onPressed: () {
                                    setState(() {
                                      if (flage1) {
                                        flage1 = false;
                                      } else {
                                        flage1 = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              helperText: "ادخل كلمة المرور القديمة",
                              contentPadding: EdgeInsets.only(
                                  left: 6, right: 6, top: 0, bottom: 15),
                              fillColor: Colors.white70),
                          obscureText: flage1,
                        ),
                      ),
                    ),
                    textDirection: TextDirection.rtl),
              ),
              Directionality(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Theme(
                      data: new ThemeData(
                        primaryColor: Colors.blueAccent,
                        primaryColorDark: Colors.red,
                      ),
                      child: TextField(
                        controller: newPass,
                        keyboardType: TextInputType.visiblePassword,
                        style: TextStyle(fontSize: 20),
                        decoration: new InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(20.0),
                              ),
                            ),
                            hoverColor: Colors.amber,
                            filled: true,
                            hintStyle: new TextStyle(color: Colors.grey[800]),
                            hintText: "",
                            alignLabelWithHint: true,
                            labelText: "كلمة المرور الجديدة",
                            hasFloatingPlaceholder: true,
                            labelStyle: TextStyle(
                                fontSize: 18,
                                backgroundColor: Colors.transparent,
                                decorationColor: Colors.transparent),
                            prefixIcon: const Icon(Icons.lock),
                            suffix: Container(
                              height: 40,
                              child: IconButton(
                                icon: flage2
                                    ? Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        size: 20,
                                      ),
                                color: Colors.blueAccent,
                                onPressed: () {
                                  setState(() {
                                    if (flage2) {
                                      flage2 = false;
                                    } else {
                                      flage2 = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            helperText: "ادخل كلمة المرور الجديدة",
                            contentPadding: EdgeInsets.only(
                                left: 6, right: 6, top: 0, bottom: 15),
                            fillColor: Colors.white70),
                        obscureText: flage2,
                      ),
                    ),
                  ),
                  textDirection: TextDirection.rtl),
              BlocBuilder<LoginScreenBloc, LoginScreenState>(
                builder: (context, state) {
                  if (state is LoginScreenUninitialized) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          elevation: 5,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text("تغيير كلمة المرور ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          ),
                          onPressed: () async {
                            if (oldPass.text.isNotEmpty &&
                                newPass.text.isNotEmpty) {
                              BlocProvider.of<LoginScreenBloc>(context).add(
                                  FetchChangePassScreen(
                                      oldPass.text, newPass.text, context));
                            } else {
                              Toast.show("أكمل جميع الحقول", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                          },
                        ),
                      ),
                    );
                  }
                  if(state is LoginScreenLoading){
                    return Container(
                          width: 40, height: 40, child: circularProgress());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
