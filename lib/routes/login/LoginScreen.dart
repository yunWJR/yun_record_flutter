import 'package:flutter/material.dart';
import 'package:yun_record/common/Http/HttpHelper.dart';
import 'package:yun_record/common/model/PageNotiInterface.dart';
import 'package:yun_record/common/page/BasePage.dart';
import 'package:yun_record/models/HomeModel.dart';
import 'package:yun_record/models/UserVo.dart';

import '../../index.dart';
import '../SplashScreen.dart';
import 'LoginNoti.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with PageNotiInterface<LoginNoti> {
  var divWidth;
  bool _autoValidate = false;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _pwdController = new TextEditingController();
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginNoti>(
        create: (context) => LoginNoti(context),
        child: Consumer<LoginNoti>(
          builder: (context, model, child) => BasePage<LoginNoti>.page(
            body: bodyWidget(model),
            model: model,
          ),
        ));

    return MultiProvider(
        providers: [
          ChangeNotifierProvider<LoginNoti>(
            create: (context) => LoginNoti(context),
//            lazy: false,
            child: Consumer<LoginNoti>(
              builder: (context, model, child) => Scaffold(
                body: BasePage<LoginNoti>.page(
                  body: bodyWidget(model),
                  model: model,
                ),
              ),
            ),
          ),
        ],
        child: Consumer<LoginNoti>(
          builder: (context, model, child) => Scaffold(
            body: BasePage<LoginNoti>.page(
              body: bodyWidget(model),
              model: model,
            ),
          ),
        ));
  }

  Widget bodyWidget(LoginNoti model) {
    divWidth = MediaQuery.of(context).size.width;

    return Scaffold(
//      appBar: AppBar(
//        title: Text('123'),
//      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[_buildSignUpForm(model)],
              )),
        ),
      ),
      backgroundColor: Colors.white, // todo
    );
  }

  Widget _buildSignUpForm(LoginNoti model) {
    //Form 1
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 50.0,
          width: 145.0,
          child: Icon(
            Icons.image,
            size: 100.0,
          ),
        ),
        new Container(
          margin: EdgeInsets.only(top: 50.0, left: 15.0, right: 15.0),
          child: new Text(
            "YUN 随记",
            maxLines: 1,
          ),
        ),
        new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          child: new TextFormField(
              controller: _nameController,
              validator: _validateUserName,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  InputDecoration(labelText: "用户名*", hintText: "请输入用户名", labelStyle: new TextStyle(fontSize: 13))),
        ),
        SizedBox(
          height: 10.0,
        ),
        new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          child: new TextFormField(
              style: new TextStyle(fontSize: kMarginPadding, color: Colors.black38),
              obscureText: true,
              validator: (String value) {
                if (value.isEmpty) {
                  return "请输入密码";
                } else {
                  return null;
                }
              },
              controller: _pwdController,
              decoration:
                  InputDecoration(labelText: "密码*", hintText: "请输入密码", labelStyle: new TextStyle(fontSize: kFontSize))),
        ),
        SizedBox(
          height: 10.0,
        ),
        new RaisedButton(
          onPressed: () => _loginButtonTapped(model),
          child: new Text("登  录"),
        ),
        new FlatButton(
            onPressed: () {},
            child: new Text(
              '忘记密码',
            )),
      ],
    );
  }

  String _validateUserName(String uName) {
    if (uName.length == null || uName.length == 0) {
      return '请输入用户名';
    }

    return null;

    // 验证用户名 todo
    Pattern pattern = r'^(13[0-9]|14[5-9]|15[0-3,5-9]|16[2,5,6,7]|17[0-8]|18[0-9]|19[0-3,5-9])\\d{8}$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(uName))
      return null;
    else
      return "请输入正确的用户名(电话号码)";
  }

  _loginButtonTapped(LoginNoti model) async {
    // 验证
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!_formKey.currentState.validate()) {
      return;
    }

    model.startLoading();

    var qP = Map<String, dynamic>();
    qP["acctName"] = _nameController.text;
    qP["password"] = _pwdController.text;

    UserVo user = await HttpHelper(model).post(UserVo(), "/v1/api/login/login", null, qP);
//    try {
//      user = await Git(context).login(_nameController.text, _pwdController.text);
//      // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
////        Provider.of<UserModel>(context, listen: false).user = user;
//    } catch (e) {
//      //登录失败则提示
//      if (e.response?.statusCode == 401) {
//        showToast('登录失败');
//      } else {
//        showToast(e.toString());
//      }
//    } finally {
//      // 隐藏loading框
//      Navigator.of(context).pop();
//    }

    if (user != null) {
//        Navigator.of(context).push(
//            MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));

      Global.userVo = user;

//        List<ThemeVo> ts = await Git(context).getThemeList();
//        print(ts);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<HomeModel>(
            create: (context) => HomeModel(context),
            child: SplashScreen(),
          ),
//            fullscreenDialog: true,
        ),
      );

//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()), (Route<dynamic> route) => false);
    }

//    await Future.delayed(Duration(seconds: 1));
//
//    model.finishLoading();
//
//    model.showErr();

//    Navigator.pushNamedAndRemoveUntil(context, "homeTab", (Route<dynamic> route) => false);

    return;
  }
}
