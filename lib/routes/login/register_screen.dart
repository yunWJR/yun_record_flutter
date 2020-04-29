import 'package:flutter/material.dart';
import 'package:yun_record/models/user_vo.dart';

import '../../index.dart';
import 'login_noti.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = "RegisterScreen";

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with YunPageNotiInterface<LoginNoti> {
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
      appBar: AppBar(
        title: Text('注册'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, bottom: 60),
//        color: Theme.of(context).primaryColor.withOpacity(0.3),
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[_buildSignUpForm(model)],
              )),
        ),
      ),
      //      backgroundColor: Colors.white, // todo
    );
  }

  Widget _buildSignUpForm(LoginNoti model) {
    //Form 1
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
            onPressed: () => _registerButtonTapped(model),
            child: new Text("注  册"),
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
  }

  _registerButtonTapped(LoginNoti model) async {
    // 验证
    FocusScope.of(context).requestFocus(new FocusNode());
    if (!_formKey.currentState.validate()) {
      return;
    }

    model.startLoading();

    UserVo user = await Api.register(model, _nameController.text, _pwdController.text);
    if (user != null) {
      YunToast.showToast("注册成功，请登录");
      Navigator.of(context).pop();
    }

    return;
  }
}
