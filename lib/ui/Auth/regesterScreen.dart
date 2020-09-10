import 'package:clothiesApp/blocs/authBloc.dart';
import 'package:clothiesApp/repostary/Repastory.dart';
import 'package:clothiesApp/ui/uiComponent/circularProgress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

class RegesterScreen extends StatefulWidget {
  RegesterScreen({Key key}) : super(key: key);

  @override
  _RegesterScreenState createState() => _RegesterScreenState();
}

class _RegesterScreenState extends State<RegesterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  bool flage = true;
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
            child: Text("أنشاء حساب",
                style: TextStyle(color: Colors.black, fontSize: 22))),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) {
          return LoginScreenBloc(PostsRepastory());
        },
        child: SingleChildScrollView(
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
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 20),
                            decoration: new InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(20.0),
                                  ),
                                ),
                                hoverColor: Colors.amber,
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                alignLabelWithHint: true,
                                labelText: "أسم المستخدم",
                                hasFloatingPlaceholder: true,
                                labelStyle: TextStyle(
                                    fontSize: 18,
                                    backgroundColor: Colors.transparent,
                                    decorationColor: Colors.transparent),
                                // counter: Text("${count}/${10}"),
                                helperText: "يجب ادخال الأسم",
                                prefixIcon: const Icon(
                                  Icons.person,
                                ),

                                // counterText: "${count}/${10}",
                                contentPadding: EdgeInsets.only(
                                    left: 6, right: 6, top: 0, bottom: 15),
                                fillColor: Colors.white70),
                          ),
                        ),
                      ),
                      textDirection: TextDirection.rtl),
                ),
                Directionality(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.blueAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: TextField(
                          controller: locationController,
                          keyboardType: TextInputType.text,
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
                              alignLabelWithHint: true,
                              labelText: "الموقع",
                              hasFloatingPlaceholder: true,
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  backgroundColor: Colors.transparent,
                                  decorationColor: Colors.transparent),
                              // counter: Text("${count}/${10}"),
                              helperText: "يجب ادخال الموقع",
                              prefixIcon: const Icon(
                                Icons.location_city,
                              ),

                              // counterText: "${count}/${10}",
                              contentPadding: EdgeInsets.only(
                                  left: 6, right: 6, top: 0, bottom: 15),
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),
                    textDirection: TextDirection.rtl),
                Directionality(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.blueAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: TextField(
                          controller: phoneNumController,
                          maxLength: 11,
                          keyboardType: TextInputType.phone,
                          style: TextStyle(fontSize: 20),
                          decoration: new InputDecoration(
                              border: new OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                ),
                              ),
                              filled: true,
                              hintStyle: new TextStyle(color: Colors.grey[800]),
                              hintText: "07712345678",
                              alignLabelWithHint: true,
                              labelText: "رقم الهاتف",
                              hasFloatingPlaceholder: true,
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  backgroundColor: Colors.transparent,
                                  decorationColor: Colors.transparent),
                              // counter: Text("${count}/${10}"),
                              helperText: "يجب ان يتكون الرقم من 11 مراتب",
                              prefixIcon: const Icon(Icons.phone),

                              // counterText: "${count}/${10}",
                              contentPadding: EdgeInsets.only(
                                  left: 6, right: 6, top: 0, bottom: 15),
                              fillColor: Colors.white70),
                        ),
                      ),
                    ),
                    textDirection: TextDirection.rtl),
                Directionality(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Theme(
                        data: new ThemeData(
                          primaryColor: Colors.blueAccent,
                          primaryColorDark: Colors.red,
                        ),
                        child: TextField(
                          controller: passController,
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
                              labelText: "كلمة المرور",
                              hasFloatingPlaceholder: true,
                              labelStyle: TextStyle(
                                  fontSize: 18,
                                  backgroundColor: Colors.transparent,
                                  decorationColor: Colors.transparent),
                              prefixIcon: const Icon(Icons.lock),
                              suffix: Container(
                                height: 40,
                                child: IconButton(
                                  icon: flage
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
                                      if (flage) {
                                        flage = false;
                                      } else {
                                        flage = true;
                                      }
                                    });
                                  },
                                ),
                              ),
                              helperText: "ادخل كلمة المرور",
                              contentPadding: EdgeInsets.only(
                                  left: 6, right: 6, top: 0, bottom: 15),
                              fillColor: Colors.white70),
                          obscureText: flage,
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
                              child: Text("تسجيل",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ),
                            onPressed: () async {
                              if (passController.text.isNotEmpty &&
                                  phoneNumController.text.isNotEmpty &&
                                  locationController.text.isNotEmpty &&
                                  usernameController.text.isNotEmpty) {
                                BlocProvider.of<LoginScreenBloc>(context).add(
                                    FetchRegesterScreen(
                                        usernameController.text,
                                        passController.text,
                                        locationController.text,
                                        phoneNumController.text,
                                        context));
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
                    if (state is LoginScreenLoading) {
                      return Container(
                          width: 40,
                          height: 40,
                          child:
                              Container(width: 50, child: circularProgress()));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
