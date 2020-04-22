import 'package:flutter/material.dart';
import 'package:yun_record/config/global_config.dart';
import 'package:yun_record/models/user_vo.dart';
import 'package:yun_record/routes/home_tab/home_tab.dart';
import 'package:yun_record/routes/login/register_screen.dart';

import '../../index.dart';
import 'login_noti.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "LoginScreen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with YunPageNotiInterface<LoginNoti> {
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
          builder: (context, model, child) => YunBasePage<LoginNoti>.page(
            body: bodyWidget(model),
            model: model,
          ),
        ));
  }

  Widget bodyWidget(LoginNoti model) {
    divWidth = MediaQuery.of(context).size.width;

    return Scaffold(
//      appBar: AppBar(
//        title: Text('123'),
//      ),
      body: Container(
        padding: EdgeInsets.only(top: 0, bottom: 80),
//        color: Theme.of(context).primaryColor.withOpacity(0.3),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  children: <Widget>[_buildSignUpForm(model)],
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpForm(LoginNoti model) {
    //Form 1
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipOval(
          child: new Container(
            color: Theme.of(context).primaryColor.withOpacity(0.5),
            child: Image(
              image: new AssetImage('assets/def_avr.png'),
              width: 100.0,
            ),
          ),
        ),
        Container(
          height: 40,
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
          height: 20.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          child: new RaisedButton(
//          color: Theme.of(context).primaryColor,
            onPressed: () => _loginButtonTapped(model),
            child: new Text("登  录"),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          child: Wrap(
            spacing: 8.0, // 主轴(水平)方向间距
            runSpacing: 4.0, // 纵轴（垂直）方向间距
            alignment: WrapAlignment.spaceBetween, //沿主轴方向居中
            children: [
              new FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterScreen.routeName);
                  },
                  child: new Text(
                    '注  册',
                    textAlign: TextAlign.left,
                    style: TextStyle(),
                  )),
              new FlatButton(
                  onPressed: () {},
                  child: new Text(
                    '忘记密码',
                    textAlign: TextAlign.right,
                  )),
            ],
          ),
        ),
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

    UserVo user = await Api.login(model, _nameController.text, _pwdController.text);
    if (user != null) {
      GlobalConfig.userVo = user;
      GlobalConfig.loginToken = user.loginToken;

      YunBaseMapModel cRst = await Api.checkTheme(model);
      print("cRst");
      print(cRst);

      Navigator.pushNamedAndRemoveUntil(context, HomeTab.routeName, (Route<dynamic> route) => false);

//      Navigator.push(
//        context,
//        MaterialPageRoute(
//          builder: (context) => ChangeNotifierProvider<HomeModel>(
//            create: (context) => HomeModel(context),
//            child: SplashScreen(),
//          ),
////            fullscreenDialog: true,
//        ),
//      );

//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()), (Route<dynamic> route) => false);
    }

    return;
  }
}
